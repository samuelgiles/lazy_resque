![lazyresque](https://user-images.githubusercontent.com/2643026/41417090-4bbacb40-6fe4-11e8-809e-3951e3dcd3a5.jpg)

# Lazy Resque

Move Resque enqueues out of the Rails request cycle to help decrease time to first byte.

## Install

From gem:
```
gem 'lazy_resque'
```

From source:
```
gem 'lazy_resque', git: 'git@github.com:samuelgiles/lazy_resque.git'
```

## Use

Trigger the actual enqueue of the jobs after the request in an `after_action` block, this can be done
by including `LazyResque::ControllerEnqueue` which will automatically add the `after_action` for you.

```ruby
class ApplicationController < ActionController::Base
  include LazyResque::ControllerEnqueue

  def index
    Resque.lazy_enqueue(MyResqueJob, 1234, 'some_job_data')
  end
end
```

## Why?

Though moving a long running task to a Resque job is beneficial the actual enqueuing process isn't free:

- Any `before_enqueue` hooks are run
- A new job instance is initialized and validated
- Arguments are dumped/encoded into JSON
- Redis `rpush` takes places requiring communication with the Redis server

This is fine for 1-2 enqueues in a request cycle but can add up to a measurable amount of time if your enqueuing several jobs.

You don't lose anything by moving the actual enqueuing outside  the request cycle and it saves precious milliseconds.

## How?

![yodawg](https://user-images.githubusercontent.com/2643026/41434108-9f6acd2a-7012-11e8-9ee6-9925090802db.png)

Internally when you call `Resque.lazy_enqueue` the job class and arguments are stored in an array on a per request thread variable, then at the end of the request via the `after_action` callback the queue is looped through and the jobs are actually sent to Resque.

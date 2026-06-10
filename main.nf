#!/usr/bin/env nextflow 
params.greeting = "Hello"
params.timeout = 10
params.exit = 0
params.cmd = "echo '$params.greeting (timeout $params.timeout)'"
params.times = 1
params.forks = 1

process foo {
  maxForks params.forks
  input: val(x)
  script:
  """
  bash -c "$params.cmd"
  sleep $params.timeout
  exit $params.exit
  """
}

workflow {
  channel.of(1..params.times) | foo
}

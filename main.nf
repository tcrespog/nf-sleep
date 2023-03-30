#!/usr/bin/env nextflow 
params.exit = 0

process foo {
  machineType 'bar'
  maxForks 1

  input:
  val x

  script:
  """
  echo "Sleeping for $x seconds"
  sleep $x
  exit $params.exit
  """
}

workflow {
  def sleepTimes = [2 * 60, 6 * 60]
  channel.of(*sleepTimes) | foo
}

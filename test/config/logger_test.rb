require 'test_helper'

describe Hanami::Config::Logger do
  let(:logger) { Hanami::Config::Logger.new }
  let(:path) { 'path/to/log/file' }

  describe '#stream' do
    it 'contains steam object' do
      logger.stream(path)
      logger.stream.must_equal path
    end

    it 'contains STDOUT value by default' do
      logger.stream.must_equal STDOUT
    end
  end

  describe '#name' do
    it 'contains name' do
      logger.app_name('test_app')
      logger.app_name.must_equal 'test_app'
    end
  end

  describe '#engine' do
    let(:engine) { ::Logger.new(STDOUT) }

    it 'contains name' do
      logger.engine(engine)
      logger.engine.must_equal engine
    end

    it 'contains nil by default' do
      logger.engine.must_equal nil
    end
  end

  describe '#build' do
    it 'returns new Hanami::Logger instance' do
      logger.build.must_be_instance_of Hanami::Logger
    end

    describe 'when stream value is set' do
      let(:io) { StringIO.new }

      it 'returns new Hanami::Logger instance with changed device' do
        logger.stream(io)
        builded_logger = logger.build

        builded_logger.must_be_instance_of Hanami::Logger
        builded_logger.instance_variable_get("@device").must_equal io
      end
    end

    describe 'when user set engine' do
      it 'returns it' do
        logger.engine(::Logger.new(STDOUT))
        builded_logger = logger.build

        builded_logger.must_be_instance_of ::Logger
      end
    end
  end
end

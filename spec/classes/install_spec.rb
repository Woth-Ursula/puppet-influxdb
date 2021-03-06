# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb::install', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) do
        <<-PUPPET
        yumrepo { ['influxdata']: }
        PUPPET
      end

      context 'ensure present' do
        let :params do
          {
            'ensure' => 'present',
            'package_name' => 'influxdb',
          }
        end

        it do
          is_expected.to compile.with_all_deps
          is_expected.to contain_class('influxdb::install')
          is_expected.to contain_package('influxdb')
            .with(ensure: 'present')
          case facts[:os]['family']
          when 'Debian'
            is_expected.to contain_class('apt')
          end
        end
      end
      context 'ensure absent' do
        let :params do
          {
            'ensure' => 'absent',
            'package_name' => 'influxdb',
          }
        end

        it do
          is_expected.to compile.with_all_deps
          is_expected.to contain_package('influxdb')
            .with(ensure: 'absent')
        end
      end
    end
  end
end

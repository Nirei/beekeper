# frozen_string_literal: true

module Beekeeper
  module SorbetRails
    module Constants
      SORBET_TYPED_STRICT_HINT = '# typed: strict'
      FROZEN_STRICT_LITERAL_HINT = '# frozen_string_literal: true'
      SORBET_EXTEND_T_SIG = 'extend T::Sig'
      SORBET_EXTEND_T_HELPERS = 'extend T::Helper'
    end
  end
end

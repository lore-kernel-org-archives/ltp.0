From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 May 2018 14:22:19 +0200
Subject: [LTP] [RFC PATCH 0/3] net: Cleanup variables in TST_PARSE_ARGS
	functions for legacy API
Message-ID: <20180503122222.2996-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is a small fix which removes using $opt and $OPTARG in legacy API
for network tests.
$1 could have been used in previous patches, support for $2 is added in
1st patch.
I'd like to add this before release (just to show good example of
TST_PARSE_ARGS usage).

I didn't add any support for help in (as it's in the new API) as instead
of tuning old API support we should just convert all new tests into new
API.


Kind regards,
Petr

Petr Vorel (3):
  lib/tst_net.sh: Pass $OPTARG as $2 to TST_PARSE_ARGS function
  net/ipsec_lib.sh: Use positional parameters in TST_PARSE_ARGS function
  net/virt_lib.sh: Use positional parameters in TST_PARSE_ARGS function

 testcases/lib/tst_net.sh                    |  2 +-
 testcases/network/stress/ipsec/ipsec_lib.sh | 24 ++++++++++++------------
 testcases/network/virt/virt_lib.sh          |  6 +++---
 3 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.16.3


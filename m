From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jul 2021 12:04:12 +0200
Subject: [LTP] [PATCH 0/3] netns_helper.sh: cleanup
Message-ID: <20210716100415.27410-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr Vorel (3):
  netns_helper.sh: Check for ping
  netns_helper.sh: Check veth with TST_NEEDS_DRIVERS
  netns_helper.sh: Formatting and style cleanup

 .../kernel/containers/netns/netns_helper.sh   | 53 ++++++++-----------
 1 file changed, 23 insertions(+), 30 deletions(-)

-- 
2.32.0


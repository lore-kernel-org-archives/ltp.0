From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Nov 2016 11:07:20 +0100
Subject: [LTP] [PATCH 1/1] network: fix network.sh -e option
Message-ID: <20161130100720.3577-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

a94a669 added 's' to filename => rename to original version

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/{net_stress.interfaces => net_stress.interface} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename runtest/{net_stress.interfaces => net_stress.interface} (100%)

diff --git a/runtest/net_stress.interfaces b/runtest/net_stress.interface
similarity index 100%
rename from runtest/net_stress.interfaces
rename to runtest/net_stress.interface
-- 
2.10.2


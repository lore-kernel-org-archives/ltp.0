From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 15:55:03 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/4] lib: Move ltp_priv.h to
	include/old/ltp_priv.h
Message-ID: <20170329135506.23901-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes out-of-tree build since ltp_priv.h is included from
include/old/test.h and the lib/ directory is not in the compiler search
path nor it's a file in the same directory in case of out-of-tree build.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 {lib => include/old}/ltp_priv.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {lib => include/old}/ltp_priv.h (100%)

diff --git a/lib/ltp_priv.h b/include/old/ltp_priv.h
similarity index 100%
rename from lib/ltp_priv.h
rename to include/old/ltp_priv.h
-- 
2.10.2


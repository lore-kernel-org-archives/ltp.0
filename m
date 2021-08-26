From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Aug 2021 17:29:16 +0200
Subject: [LTP] [PATCH 1/4 v2] api: Add a IS_BIT_SET() macro in
 tst_bitmap.h
In-Reply-To: <OSZP286MB0871E8F61CE0773AF89CF35FCCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
References: <20210825153932.138396-1-ziyaoxie@outlook.com>
 <OSZP286MB0871E8F61CE0773AF89CF35FCCC69@OSZP286MB0871.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <YSezTHKUL9fgKn6a@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add a IS_BIT_SET() macro in tst_bitmap.h to check whether the n-th bit
> of val is set.

Since this has been put into the test library I've changed this to
TST_IS_BIT_SET() and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

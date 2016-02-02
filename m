From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 16:48:12 +0100
Subject: [LTP] [PATCH V2 05/32] kernel/controllers: Link with libfts
 explicitly on musl
In-Reply-To: <1452302060-103643-5-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-5-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202154812.GF19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> musl does not implement fts like glibc and therefore it depends on
> external implementation for all fts APIs

DTTO, this should be configure test that would check if fts APIs needs
-lfts. The test should export FTS_LIBS in config.mk which would be set
to -lfts if needed and used in the corresponding Makefiles,

-- 
Cyril Hrubis
chrubis@suse.cz

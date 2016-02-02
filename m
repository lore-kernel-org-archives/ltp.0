From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 17:51:21 +0100
Subject: [LTP] [PATCH V2 21/32] Define _GNU_SOURCE for MREMAP_MAYMOVE
 definition
In-Reply-To: <1452302060-103643-21-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-21-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202165121.GK19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> musl guards MREMAP_MAYMOVE with _GNU_SOURCE unlike glibc which uses
> __USE_GNU
> 
> Fixes errors like
> error: 'MREMAP_MAYMOVE' undeclared (first use in this function)

This will break on glibc. The correct solution is to define the
_GNU_SOURCE before we include any headers and there is no point in
undefining it later. And the __USE_GNU is glibc internal macro that
should not be set at all...

-- 
Cyril Hrubis
chrubis@suse.cz

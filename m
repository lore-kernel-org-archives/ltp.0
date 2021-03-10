From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Mar 2021 16:14:42 +0100
Subject: [LTP] [PATCH 1/3] open_posix_testsuite/generate-makefiles.sh:
 Avoid inconsistencies with make version
In-Reply-To: <20210309155623.2457857-1-richard.purdie@linuxfoundation.org>
References: <20210309155623.2457857-1-richard.purdie@linuxfoundation.org>
Message-ID: <YEjiYkuyGvs8QT8T@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Patchset pushed, thanks.

Also it looks like the wildcard used to be sorted but they removed that
in a few make versions and nobody knows why:

https://stackoverflow.com/questions/40558385/gnu-make-wildcard-no-longer-gives-sorted-output-is-there-any-control-switch

-- 
Cyril Hrubis
chrubis@suse.cz

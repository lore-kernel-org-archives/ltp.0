From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 16:36:14 +0200
Subject: [LTP] [PATCH v2] syscalls/fcntl34: Use flock64 instead of flock
In-Reply-To: <1471351741-20639-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1471351741-20639-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20160816143614.GB26323@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This test uses OFD locks which are supported only by 64-bit ABI.
> Thus OFD locks must be used with flock64 structure for sure in this
> test. It is necessary because on some 32-bit targets (e.g. 32-bit
> uClibc) flock is not mapped to flock64 when _FILE_OFFSET_BITS is not
> set to 64.

Applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

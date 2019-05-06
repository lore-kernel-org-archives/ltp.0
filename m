From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 06 May 2019 12:14:13 +0200
Subject: [LTP] NS_* ioctl commands fail in 32bit compat mode (-m32)
In-Reply-To: <20190412143318.GA29856@haruka.lan>
References: <20190403152245.GC26464@rei.lan>
 <20190411192534.30525-1-fedebonfi95@gmail.com>
 <20190412143318.GA29856@haruka.lan>
Message-ID: <874l67x53e.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hello Federico,

All the tests fail with something similar to:
ioctl_ns01.c:45: FAIL: unexpected ioctl error: ENOTTY

when compiled with the -m32 flag on at least SUSE kernel 4.20 and
4.12.

Do you know if this feature is expected to work in 32bit compat mode?
Maybe the size of the arguments should be different when using 32bit mode?

--
Thank you,
Richard.

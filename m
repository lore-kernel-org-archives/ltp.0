From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 16:41:07 +0100
Subject: [LTP] [PATCH V2 09/32] Guard error.h with __GLIBC__
In-Reply-To: <1452302060-103643-9-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-9-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202154107.GD19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> error API is specific to glibc so use the guard to make it conditional
> on glibc

I've looked at fist three tests in question and none of them actually
uses the error() function defined in error.h.

So the right thing to do here is to remove the #include <error.h> line
from the testcases.

-- 
Cyril Hrubis
chrubis@suse.cz

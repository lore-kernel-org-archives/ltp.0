From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Feb 2020 07:49:34 +0100
Subject: [LTP] [PATCH v2 1/1] lap/syscalls: Update syscall numbers
In-Reply-To: <20200226232649.8736-1-pvorel@suse.cz>
References: <20200226232649.8736-1-pvorel@suse.cz>
Message-ID: <20200228064934.GA30424@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> TODO: not sure about spu and nospu ABI in powerpc (whether they go to
> 32 bit or 64 bit or is ignored)
OK: 32bit uses "common,nospu,32" and 64bit uses "common,nospu,64"
spu can be ignored for both.
=> patch is correct.

Kind regards,
Petr

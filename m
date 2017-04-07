From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Apr 2017 13:44:54 +0200
Subject: [LTP] [RFC] [PATCH v2] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170407133242.6dd04be2@linux-v3j5>
References: <20170406124641.30179-1-chrubis@suse.cz>
 <20170407105832.6f9d811a@linux-v3j5> <20170407091945.GA536@rei.lan>
 <20170407133242.6dd04be2@linux-v3j5>
Message-ID: <20170407114454.GA28572@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Build still fails however, because of missing 32-bit libraries, but that is
> just because the headers are present for the 64-bit lib and a lot of tests
> will try to build so long as the headers are there. I guess it would be better
> to also check that we can link as well, which some tests appear to do. I think
> it is quite a reasonable workaround to just install the libs though assuming
> that they will all usually be available if any 32-bit libs are.

We may try to fix the build system to try linking with the libraries as
well but that is unrelated problem that is there from the start.

-- 
Cyril Hrubis
chrubis@suse.cz

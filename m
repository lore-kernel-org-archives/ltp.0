From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Dec 2018 13:39:31 +0100
Subject: [LTP] Question about strncpy_2-1
In-Reply-To: <5C0F83AC.8070902@cn.fujitsu.com>
References: <5C0F83AC.8070902@cn.fujitsu.com>
Message-ID: <20181211123931.GC27346@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> With old gcc version(e.g. gcc-4.4), compiling strncpy_2-1 gets the following error:
> ----------------------------------------------------------------------------------
> ../../../conformance/interfaces/strncpy/1-1.c: In function ???main???:
> ../../../conformance/interfaces/strncpy/1-1.c:64: error: #pragma GCC diagnostic not allowed inside functions
> ../../../conformance/interfaces/strncpy/1-1.c:65: error: #pragma GCC diagnostic not allowed inside functions
> ../../../conformance/interfaces/strncpy/1-1.c:67: error: #pragma GCC diagnostic not allowed inside functions
> conformance/interfaces/strncpy/1-1 compile FAILED; SKIPPING
> ----------------------------------------------------------------------------------
> 
> It seems that push/pop is supported and pragma diagnostic is allowed inside functions
> since commit 0955be6 in GCC.

Looks like an attempt to silence warnings, but a lousy one that would
break on anything but new enough gcc, let's get rid of that.

-- 
Cyril Hrubis
chrubis@suse.cz

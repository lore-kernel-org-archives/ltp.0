From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 11 Dec 2018 17:59:47 +0800
Subject: [LTP] Question about strncpy_2-1
In-Reply-To: <5C0F83AC.8070902@cn.fujitsu.com>
References: <5C0F83AC.8070902@cn.fujitsu.com>
Message-ID: <5C0F8A93.20800@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 2018/12/11 17:30, Xiao Yang wrote:
> Hi all,
>
> With old gcc version(e.g. gcc-4.4), compiling strncpy_2-1 gets the following error:
> ----------------------------------------------------------------------------------
> ../../../conformance/interfaces/strncpy/1-1.c: In function ‘main’:
> ../../../conformance/interfaces/strncpy/1-1.c:64: error: #pragma GCC diagnostic not allowed inside functions
> ../../../conformance/interfaces/strncpy/1-1.c:65: error: #pragma GCC diagnostic not allowed inside functions
> ../../../conformance/interfaces/strncpy/1-1.c:67: error: #pragma GCC diagnostic not allowed inside functions
> conformance/interfaces/strncpy/1-1 compile FAILED; SKIPPING
> ----------------------------------------------------------------------------------
>
> It seems that push/pop is supported and pragma diagnostic is allowed inside functions
> since commit 0955be6 in GCC.
>
> It is clear for me to know tha fact that current gcc version doesn't support above pragma
> diagnostic code, so anyone can tell me if we should keep the error?
Hi all,

In addition, this compiler error doesn't break the whole openposix compilation.

Best Regards,
Xiao Yang

> Best Regards,
> Xiao Yang
>
>
>
>




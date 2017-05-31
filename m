From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 31 May 2017 13:21:27 +0200
Subject: [LTP] Fwd: LTP compilation with UCLibC Toolchain
In-Reply-To: <CAJ_4j44etZ3dUgNTjbNtxLa9SEU9hcVg1c6zH6tiaQhVL9ba4w@mail.gmail.com>
References: <CAJ_4j45XaQTfA02kxYHa6XeRCmD5TxCP1n5nAMSivf-iWSBYOA@mail.gmail.com>
 <CAJ_4j44etZ3dUgNTjbNtxLa9SEU9hcVg1c6zH6tiaQhVL9ba4w@mail.gmail.com>
Message-ID: <20170531112126.GD2276@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>     I'am cross-compiling LTP with attitude_adjustment UCLibc toolchain, but
> getting compilation error "undefined reference" for "fsetxattr", "setxattr"
> and "lsetxattr" functions.
> 
> I checked the common config file "include/bits/uClibc_config.h" of
> attitude_adjustment  toolchain and macro "__UCLIBC_HAS_XATTR__" is
> undefined.
> But this macro is defined in toolchain of "chaos calmer" release.
> 
> I am stuck at this point as it seems attitude_adjustment toolchain does not
> have XATTR support.
> Is there any way to enable this macro, so that i can compile LTP
> successfully.
> 
> Any kind of help is appreciated.

Looks like you are asking on the wrong list here, you should rather ask
on the uClibc mailing list, which is better suited to answer uClibc
related questions.

Also "chaos calmer" and "attitude adjustement" seems to be OpenWrt
release names, so it looks like you are mixing different things
together. Questions about OpenWrt SDK should be asked on OpenWrt mailing
list etc.

-- 
Cyril Hrubis
chrubis@suse.cz

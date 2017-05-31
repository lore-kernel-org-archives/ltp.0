From: khushbu sharma <sharma.khushbu850@gmail.com>
Date: Wed, 31 May 2017 15:12:05 +0530
Subject: [LTP] Fwd: LTP compilation with UCLibC Toolchain
In-Reply-To: <CAJ_4j45XaQTfA02kxYHa6XeRCmD5TxCP1n5nAMSivf-iWSBYOA@mail.gmail.com>
References: <CAJ_4j45XaQTfA02kxYHa6XeRCmD5TxCP1n5nAMSivf-iWSBYOA@mail.gmail.com>
Message-ID: <CAJ_4j44etZ3dUgNTjbNtxLa9SEU9hcVg1c6zH6tiaQhVL9ba4w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

hi,
    I'am cross-compiling LTP with attitude_adjustment UCLibc toolchain, but
getting compilation error "undefined reference" for "fsetxattr", "setxattr"
and "lsetxattr" functions.

I checked the common config file "include/bits/uClibc_config.h" of
attitude_adjustment  toolchain and macro "__UCLIBC_HAS_XATTR__" is
undefined.
But this macro is defined in toolchain of "chaos calmer" release.

I am stuck at this point as it seems attitude_adjustment toolchain does not
have XATTR support.
Is there any way to enable this macro, so that i can compile LTP
successfully.

Any kind of help is appreciated.

Thanks
Khushboo
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170531/91f92ac9/attachment.html>

From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 Dec 2018 18:35:42 +0100
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
Message-ID: <20181204173542.GD30799@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Perhaps, we could add some hints about the invalid ttype.
> > e.g. "tst_brk(): invalid type, please use TBROK/TCONF/TFAIL"

> Do you have suggestion how to achieve that?

> There's an __attribute__(error), but it's supported only from gcc 4.3 as I recall.
Do you mean __attribute__ format?

> Alternative would be link time failure, with a symbol name suggesting what went wrong.
Not sure, how exactly you want to do it, but seems to be more portable than
requiring specific gcc version (although 4.3 is very old and __attribute__
format is supported by clang as well).


Kind regards,
Petr

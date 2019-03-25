From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Mar 2019 10:50:54 +0100
Subject: [LTP] [PATCH v3 1/2] tst_test: Add test multiplex function
In-Reply-To: <20190322171134.899-2-chrubis@suse.cz>
References: <20190322171134.899-1-chrubis@suse.cz>
 <20190322171134.899-2-chrubis@suse.cz>
Message-ID: <20190325095054.GA10821@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Nice! Whole patchset LGTM, one typo below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +2.2.29 Testing similar syscalls in one test
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In some cases kernel has several very similar syscalls that do either the same
> +or very similar job. This is most noticeable on i386 where we commonly have
> +two or three syscall versions. That is because i386 was first platform that
> +Linux was developed on and because of that most mistakes in API happened there
> +as well. However this is not limited to i386 at all, it's quite common that
> +version two syscall has added missing flags parameters or so.
> +
> +In such cases it does not make much sense to copy&paste the test code over and
> +over, rather than that the test library provides support for test variants.
> +The idea behind test variants is simple, we run the test several times each
> +time with different syscall variant.
> +
> +The implemenation consist of test_variant integer that, if set, denotes number
Typo => implementation


Kind regards,
Petr

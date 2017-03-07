From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Mar 2017 14:21:48 +0100
Subject: [LTP] [PATCH v2 5/6] syscalls: added memfd_create dir and
 memfd_create/memfd_create01.c
In-Reply-To: <4c535df1-1244-4d8b-ecb0-cfbe8b771e1b@redhat.com>
References: <1488822340-29259-1-git-send-email-jracek@redhat.com>
 <1488822340-29259-6-git-send-email-jracek@redhat.com>
 <20170307121756.GC1261@rei.lan>
 <4c535df1-1244-4d8b-ecb0-cfbe8b771e1b@redhat.com>
Message-ID: <20170307132148.GA7908@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> SAFE_MFD_NEW and others should go to "include/tst_safe_macros.h", right?

That one is too big at this point. And I guess that this call would not
be usefull anywhere else than this testsuite, so having it in local
header should be fine.

> If I undestand this correctly, negative testcases will have to stay in
> memfd_create_common.h. That means I can't use
> SAFE_ macros in those functions/macros, as that would obscure line
> numbers. And putting those elsewhere would duplicate a lot of code.

Hmm, we can always use the functions SAFE_MACROS call and pass filename
and line number explicitly.

#define FAIL_MFD_FOO(foo, bar) \
	fail_mfd_foo(__FILE__, __LINE__, foo, bar)

void fail_mfd_foo(const char *file, const int lineno, int foo, int bar)
{
	int ret;

	ret = safe_foo(file, lineno, foo);

	...
}

-- 
Cyril Hrubis
chrubis@suse.cz

From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 20 Jan 2021 18:07:15 +0100
Subject: [LTP] [PATCH] tst_pollute_memory(): Set minimal safety margin
 to 64MB
In-Reply-To: <CA+G9fYtKz+mW4S3SjgNDomPKo8JbVh9SyQYbbj92xZYxuEmG1Q@mail.gmail.com>
References: <20210118163240.29558-1-mdoucha@suse.cz>
 <YAbT62ecN/lq12cT@yuki.lan>
 <CA+G9fYv_6tiMrF38jLPYK=C6D+LNBndun1XuGQJiOK60LhYRyA@mail.gmail.com>
 <YAhEEzWShFLlHrk1@yuki.lan>
 <CA+G9fYuDpnJOcHA5Me4KM4v+NaFW=2_3id=Am6skbDavb1iACw@mail.gmail.com>
 <YAhHAWTedDb/6Hd/@yuki.lan>
 <CA+G9fYtKz+mW4S3SjgNDomPKo8JbVh9SyQYbbj92xZYxuEmG1Q@mail.gmail.com>
Message-ID: <c27fc2aa-b24d-ce1e-0e09-6364ccdae9e4@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20. 01. 21 18:04, Naresh Kamboju wrote:
> On Wed, 20 Jan 2021 at 20:35, Cyril Hrubis <chrubis@suse.cz> wrote:
>>>>
>>>> So it looks like 64MB is not enough in your case.
>>>>
>>>> Does it work with 128MB or 256MB?
>>>>
>>>> i.e.:
>>>>
>>>> safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
> 
> After changing to 128MB the test got PASS with overcommit_memory 0 on x86_64.

OK, let's go with 128MB then.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

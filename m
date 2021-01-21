From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Jan 2021 10:45:23 +0100
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
Message-ID: <YAlNMwFBMAiNEWfL@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> After changing to 128MB the test got PASS with overcommit_memory 0 on x86_64.

Thanks a lot, fix pushed.

-- 
Cyril Hrubis
chrubis@suse.cz

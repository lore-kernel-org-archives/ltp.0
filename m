From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Wed, 16 Jun 2021 07:22:40 +0000
Subject: [LTP] [PATCH v2] syscalls/mallinfo2_01: Add a basic test for
 mallinfo2 when setting 2G size
In-Reply-To: <YMmiQfWgvqtCzOmg@pevik>
References: <YKzX7FPWGGROn6kR@pevik>
 <1622713444-21197-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YMmiQfWgvqtCzOmg@pevik>
Message-ID: <60C9A6D7.2080102@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi Xu,
>
>> +++ b/testcases/kernel/syscalls/mallinfo2/Makefile
> ...
>> +
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +
>> +CFLAGS += -I../mallinfo
> Also this needs to be
> CFLAGS += -I$(abs_srcdir)/../mallinfo
>
You are right. It will fail when out of tree.
> otherwise out of tree builds fail:
> https://github.com/pevik/ltp/actions/runs/941820122
>
> BTW Cyril also suggested recently to drop out of tree support, because build
> system dependencies are broken and fixing it would be much easier when
> supporting only in tree build.
On my test envrionment, I never use out of tree build. So I am fine with 
removing it.
>
> Kind regards,
> Petr

From: Eddie Horng <eddiehorng.tw@gmail.com>
Date: Wed, 12 Sep 2018 09:44:33 +0800
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <1149740228.46962437.1536679477401.JavaMail.zimbra@redhat.com>
References: <1533111474.1176.4.camel@mtkswgap22>
 <1149740228.46962437.1536679477401.JavaMail.zimbra@redhat.com>
Message-ID: <CALLuPvqTLbtY1yFNFRgdTkf2keR1FoCF0RGrf_TREfWAvOy_JA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Jan Stancek <jstancek@redhat.com> 於 2018年9月11日 週二 下午11:24寫道：
> We should fix this for release. If EINVAL is expected behaviour,
> test should give PASS.
>
> It's failing with 4.18:
>
> tst_test.c:1063: INFO: Timeout per run is 0h 05m 00s
> execveat03.c:71: FAIL: execveat() returned unexpected errno: EINVAL
>

Hi Jan,
The fix of original regression, ie. EINVAL returns in execveat03 test case,
has been added to 4.18-stable and 4.14-stable:
https://www.spinics.net/lists/stable/msg255906.html
https://www.spinics.net/lists/stable/msg255724.html
If give EINVAL as PASS, the case will PASS with or without the regression
fix. I'm not sure which behavior of execveat03 is more appropriate.
Please advise.

Thanks,
Eddie

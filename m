From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Jun 2018 19:52:03 +0530
Subject: [LTP] LTP CVE "cve-2011-2183" failed on x86_64,
	arm32 beaglebone x15
In-Reply-To: <20180604123201.GD3362@rei>
References: <CA+G9fYuUAPvwBjXjw_EATrMoLPtS5imGo7foqchmAFD=TUdVXQ@mail.gmail.com>
 <20180604120733.GC3362@rei> <20180604123201.GD3362@rei>
Message-ID: <CA+G9fYswkNnG27CRgpYqBh5LNMMVXTaOYJHMheL2nEzx0_6_8Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 4 June 2018 at 18:02, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> That is an obvious bug in the test, the value of run should be restored
>> only if we managed to change it.
>
> I've pushed a slightly different patch that fixes the issue:
>
> https://github.com/linux-test-project/ltp/commit/ffc8005a002ecc6f0d70675f7dee79cd481acffc
>
> Thanks for the report.

Thanks for the quick patch.
Happy testing :)

- Naresh

>
> --
> Cyril Hrubis
> chrubis@suse.cz

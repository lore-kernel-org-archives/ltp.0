From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Sep 2017 13:00:39 -0700
Subject: [LTP] LTP release and code freeze
In-Reply-To: <20170919080444.GA14080@rei>
References: <CA+G9fYs59g3eHyucNRJQ1+vxmwykZ_hHaUbANREpHXJ9C9u=TQ@mail.gmail.com>
 <20170919080444.GA14080@rei>
Message-ID: <CA+G9fYtTBa4rva8eBZoxoBb31r6hSVXbmOSBn=uFAGSLGqnwyQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On 19 September 2017 at 01:04, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> Regarding the LTP September 2017 release,
>> Identifying bugs / issues / limitation / pre-requirements of LTP
>> testing on ARM64 architecture is crucial at our end. We would like to
>> test LTP pre-release candidate on ARM64 architecture.
>> Please announce code freeze and allow time to validate test code.
>
> I guess that you can start with the validation now. We haven't declared
> the freeze formally yet, but there are only a few possible changes that
> may get in the release. The thp01 is broken on new kernels, that one
> should get in for sure. Then possibly something like ten tests may end
> up affected by possible changes in the CVE tests, which should be easy
> enough to retest if needed.

Tested LTP syscalls on ARM64 architecture and the results looks good
on 4.12 and 4.13 kernel.

Summary,
Total Tests: 1136
Total Skipped Tests: 115
Total Failures: 0
Machine Architecture: aarch64

The reason for 115 skip are due to $(testcase)_16 and libnuma/NUMA
related tests were skipped.

- Naresh

>
> --
> Cyril Hrubis
> chrubis@suse.cz

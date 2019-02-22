From: Steve Muckle <smuckle@google.com>
Date: Fri, 22 Feb 2019 11:58:18 -0800
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <20190220151248.GB32140@rei>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
 <CAFA6WYO8qg79rQ-qwU3i6FpfNRQhiTNXzGHtDsJ6FpTty6W77g@mail.gmail.com>
 <20190215121611.GA14270@rei>
 <CAFA6WYOF1Kh1rspdiPgne9q4jUQsMW4p5BN_J4evcsr9O-KD1Q@mail.gmail.com>
 <20190215132251.GB26339@rei>
 <4cae2a11-47c2-c319-19cf-9a8fecc7793d@google.com>
 <20190218115746.GA25025@rei.lan>
 <6c93cc5b-f871-0160-0e81-0d964059cdf2@google.com> <20190220131443.GA5256@rei>
 <20190220151248.GB32140@rei>
Message-ID: <e9559685-f850-69ea-7d67-c587e9cc3314@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/20/2019 07:12 AM, Cyril Hrubis wrote:
> Hi!
>>> Sure. My concern is being able to test syscalls in Android where the C
>>> library may not have some wrappers. So far these have all been cases
>>> where one can just replace the library call with the direct syscall, as
>>> a number of recent patches have done. If I run into a case where more
>>> substantial library support is needed maybe we'll just have to focus on
>>> getting that into bionic or look at other options.
>>
>> I guess that we can also auto-generate fallback syscall wrappers for
>> these cases so that we don't have to bother dealing with this in the
>> actual testcases. Should be as easy as listing the function prototypes
>> in a file and a few lines of shell.
> 
> Thinking of this, generating fallbacks is the easy part, figuring out
> when to use them is the complex one. I wanted to use a trick with weak
> function symbols so that the linker would pick up these fallbacks only
> if there was no system defintion but that unfortunately does not work
> because glibc uses weak symbols for symbol versioning. I guess that we
> can use autoconf to generate fallback functions automatically if syscall
> wrapper is found to be missing, but that would be a bit ugly code. Also
> do you even use the configure script on android builds?

We do use the configure script. But I guess given the discussion in the 
other thread, hopefully both the libc wrapper and direct syscall can be 
tested.

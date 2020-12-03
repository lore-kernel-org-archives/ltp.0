From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 3 Dec 2020 15:34:17 +0100
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <20201203123041.GB5809@yuki.lan>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
 <0c6f7b59-c1ec-5ff9-d261-7b4772ed9b1a@suse.cz>
 <20201203123041.GB5809@yuki.lan>
Message-ID: <400e683b-97a6-bab6-702c-365937c406e8@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03. 12. 20 13:30, Cyril Hrubis wrote:
> Hi!
>> I'd recommend adding TEST_*_IMPL() variant with extra arguments that'll
>> allow special handling of ENOSYS, ENOTSUP and possibly also a
>> zero-terminated array of allowed errnos. TEST_FD() etc. would then call
>> the respective IMPL macro with default arguments:
>>
>> #define TEST_FD_IMPL(SCALL, NOSYS_RES, NOTSUP_RES, ERRNO_LIST, ...) \
>>     ...
>>
>> #define TEST_FD(SCALL, ...) \
>>     TEST_FD_IMPL((SCALL), TFAIL, TFAIL, NULL, ##__VA_ARGS__)
> 
> I do plan adding something like this later on once I run out of the
> simple cases to convert, then I would like to review what is left there
> and how to make best interface for the rest of the testcases.
> 
> So for now I would like to proceed with the patchset as it is in order
> not to make it overly complicated.

Great, looking forward to the follow-up patchset. I haven't reviewed
everything so I won't add any signoff but consider my comments resolved.
Feel free to push the patchset when you have enough reviews from others.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

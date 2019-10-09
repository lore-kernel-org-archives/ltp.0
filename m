From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 9 Oct 2019 13:53:29 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <20191009114854.GC7561@rei.lan>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-3-lkml@jv-coder.de> <20191009113919.GB7561@rei.lan>
 <64bb824c-d577-86e5-bfa5-17a8cfbf4174@jv-coder.de>
 <20191009114854.GC7561@rei.lan>
Message-ID: <22bc4865-295c-3147-8e26-f258fac472f8@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


>>> Can we keep the name to be tst_require_root() please?
>>>
>>> Historically this function has been always named like this in LTP.
>>>
>> Not a very good argument for two reasons:
>> 1. The function was internal to the library, so no one (except for
>> library developers)
> It has been in a public API for the old library for more than ten years
> before the new library was written.
Has been, but is not anymore. But I accept it as an argument.
>
>> 2. I wanted to make it consistent with other functions, that do similar
>> stuff like
>>   ???? tst_test_drivers and tst_test_cmds. Both also call tst_brk in case
>> of unsuccessful tests.
> Well I do not like these names either, it's less descriptive that it
> would have been with tst_require_cmds and tst_require_drivers, so if
> anything I would be for renaming the tst_test_* ones.
Fair enough, that makes sense. But then we require a change to 
tst_test_* first,
otherwise the api names are inconsistent. And I'm not sure if changing the
other functions is really worth it.

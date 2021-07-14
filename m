From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 14 Jul 2021 14:26:48 +0100
Subject: [LTP] [PATCH v2 3/8] doc: Add rules and recommendations list
In-Reply-To: <YO7CU8UebcFN2VtY@pevik>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
 <20210714071158.15868-4-rpalethorpe@suse.com> <YO7CU8UebcFN2VtY@pevik>
Message-ID: <87sg0hni07.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> +++ b/doc/test-writing-guidelines.txt
>> @@ -10,6 +10,11 @@ NOTE: See also
>>        https://github.com/linux-test-project/ltp/wiki/Shell-Test-API[Shell Test API],
>>        https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines[LTP Library API Writing Guidelines].
>
>> +Rules and recommendations which are "machine checkable" should be
>> +tagged with an ID like +LTP-XXX+. There will be a corresponding entry
>> +in 'doc/rules.tsv'. When you run 'make check' or 'make check-test' it
>> +will display these IDs as a reference.
>> +
> Actually text is on the top. I suppose, you probably planned to put
> this into "2.1 C coding style".

I'm not sure where to put it. The coding style is mostly about syntax
and formatting. The rules file can state anything machine checkable, so
that can include shell, directory structure, what functions are used
etc.

>
> Kind regards,
> Petr
>
>>  1. Guide to clean and understandable code
>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-- 
Thank you,
Richard.

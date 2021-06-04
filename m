From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 04 Jun 2021 10:03:40 +0100
Subject: [LTP] [RFC PATCH 0/2] Libclang based analyzer
In-Reply-To: <YLnGIJWPf2XsAdTt@pevik>
References: <20210603154825.30165-1-rpalethorpe@suse.com>
 <YLnGIJWPf2XsAdTt@pevik>
Message-ID: <875yyuj91v.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Hello,
>
>> This implements a TEST() check and integrates the check into the build
>> system.
>
>> Compared to the Coccinelle version it's very ugly. However I think
>> this will allow us to get all the low hanging fruit without creating
>> major problems for test developers.
>
>> I guess it could be run during CI if we either fix all the existing
>> TEST() usages in the library or add an ignore list. I already have a
>> Coccinelle script to help with the former.
> +1.
>
> FYI yesterday I sent patch to add make check{,-c,shell}, but for running C/shell API tests:
> https://patchwork.ozlabs.org/project/ltp/list/?series=247103

So I guess we have a name collision here. Something to consider is that
GNU Make defines 'checks' as running self tests. So perhaps you are
correct to use that word.

I could rename the static analyses to 'analyze' or 'lint'. OTOH it might
be better if running the self tests is called 'make
run-{c,shell}-api-tests', because only a few people need to do
that. Whereas it is intended that all contributors run the static
analyses checks.

Although, if someone runs 'make check' in the lib directory, then it
makes sense to run the C API tests as well as do the analyses. Or not?

>
> Taking 2 latests commits + adding clang-devel / libclang-dev packages makes CI
> running.
>
> https://github.com/pevik/ltp/commit/b2427f39ddb15c97761208a605637e0da6fe66ca

Thanks, I guess this shows that libclang is well supported.

>
> The only missing piece is include/mk/clang-checks.mk (this patchset not even
> compile now).
>
>> Richard Palethorpe (2):
>>   Add 'make checks' and clang-checks to build system
> make check ... clang-check (to avoid confusion).
>
>>   Start libclang based analyzer and TEST() check
>
>>  configure.ac                       |   2 +
>>  include/mk/config.mk.in            |   5 +
>>  include/mk/env_post.mk             |   8 ++
>>  include/mk/generic_leaf_target.inc |   5 +-
>>  include/mk/lib.mk                  |   3 +
>>  include/mk/rules.mk                |   9 ++
>>  include/mk/testcases.mk            |   1 +
>>  tools/clang-checks/.gitignore      |   1 +
>>  tools/clang-checks/Makefile        |  13 ++
>>  tools/clang-checks/main.c          | 218 +++++++++++++++++++++++++++++
> I'd name it tools/clang-check/ (and include/mk/clang-check.mk), but that's just
> personal opinion.

Yeah, we do not want a mixture of check and checks. I should probably
just make it 'check' as it saves typing one letter.

>
> Kind regards,
> Petr
>
>>  10 files changed, 264 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/clang-checks/.gitignore
>>  create mode 100644 tools/clang-checks/Makefile
>>  create mode 100644 tools/clang-checks/main.c


-- 
Thank you,
Richard.

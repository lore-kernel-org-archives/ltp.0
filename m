From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 14 Jun 2021 12:09:31 +0100
Subject: [LTP] [RFC PATCH v2 1/2] Add 'make check' and clang-check to
 build system
In-Reply-To: <YMNwj5509FviXCza@pevik>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <20210604111434.21422-2-rpalethorpe@suse.com> <YMNqB2j57/b7ESJB@pevik>
 <YMNwj5509FviXCza@pevik>
Message-ID: <87tum04s9g.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>> Hi Richie,
>
>> one more proposal (addition to Metan's fix [1]):
>> how about to add top level make check target:
>
>> diff --git Makefile Makefile
>> index 56812d77b..b65315618 100644
>> --- Makefile
>> +++ Makefile
>> @@ -79,6 +79,7 @@ BOOTSTRAP_TARGETS	:= $(sort $(COMMON_TARGETS) $(CLEAN_TARGETS) $(INSTALL_TARGETS
>>  CLEAN_TARGETS		:= $(addsuffix -clean,$(CLEAN_TARGETS))
>>  INSTALL_TARGETS		:= $(addsuffix -install,$(INSTALL_TARGETS))
>>  MAKE_TARGETS		:= $(addsuffix -all,$(filter-out lib,$(COMMON_TARGETS)))
>> +CHECK_TARGETS		:= $(addsuffix -check,testcases lib)
>
>>  # There's no reason why we should run `all' twice. Otherwise we're just wasting
>>  # 3+ mins of useful CPU cycles on a modern machine, and even more time on an
>> @@ -99,6 +100,11 @@ INSTALL_DIR		:= $(abspath $(INSTALL_DIR))
>>  $(sort $(addprefix $(abs_top_builddir)/,$(BOOTSTRAP_TARGETS)) $(INSTALL_DIR) $(DESTDIR)/$(bindir)):
>>  	mkdir -m 00755 -p "$@"
>
>> +$(CHECK_TARGETS):
>> +	echo "CHECK_TARGETS: $(CHECK_TARGETS)"; \
> This should be obviously left out (my debug message).
>> +	$(MAKE) -C "$(subst -check,,$@)" \
>> +		-f "$(abs_top_srcdir)/$(subst -check,,$@)/Makefile" all
> This should be check target
> 		-f "$(abs_top_srcdir)/$(subst -check,,$@)/Makefile" check
>> +
>>  ## Pattern based subtarget rules.
>>  lib-install: lib-all
>
>> @@ -189,6 +195,9 @@ INSTALL_TARGETS		+= $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))
>
>>  $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)
>
>> +## Check
>> +check: $(CHECK_TARGETS)
>> +
>>  ## Install
>>  install: $(INSTALL_TARGETS)
>
>> ---
>
> + there needs to be check added to RECURSIVE_TARGETS
> +++ include/mk/generic_trunk_target.inc
> @@ -48,7 +48,7 @@
>  
>  include $(top_srcdir)/include/mk/functions.mk
>  
> -RECURSIVE_TARGETS		?= all install
> +RECURSIVE_TARGETS		?= all install check
>  
>  $(eval $(get_make_dirs))
>  
> ---
>
> Kind regards,
> Petr

Thanks. It appears defining trunk-check (similar to check-all) and
"check: trunk-check" in addition to adding check to the recursive
targets seems to work.

-- 
Thank you,
Richard.

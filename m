From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 09 Jun 2021 11:28:14 +0100
Subject: [LTP] [PATCH v2 1/2] Add Coccinelle helper scripts for reference
In-Reply-To: <YMCAe9PO5NMToFOq@pevik>
References: <20210607141421.15072-1-rpalethorpe@suse.com>
 <YMCAe9PO5NMToFOq@pevik>
Message-ID: <875yyn5o3l.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Check-in a couple of scripts used for removing the TEST macro from the
>> library. Also a shell script to show how to run them. These are only
>> intended to help someone develop their own refactoring scripts. Not
>> for running automatically.
> Nice, LGTM, with two notes bellow.
>
>> +++ b/scripts/coccinelle/run-spatch.sh
>> @@ -0,0 +1,39 @@
>> +#!/bin/sh -eu
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# Copyright (c) 2021 SUSE LLC  <rpalethorpe@suse.com>
>> +
>> +# Helper for running spatch Coccinelle scripts on the LTP source tree
>> +
>> +if [[ ! -d lib || ! -d scripts/coccinelle ]]; then
> [[ ... ]] is bashism. It should be
> if [ ! -d lib ] || [ ! -d scripts/coccinelle ]; then

+1

>
> or
>
>> +    echo "$0: Can't find lib or scripts directories. Run me from top src dir"
>> +    exit 1
>> +fi
>> +
>> +# Run a script on the lib dir
>> +libltp_spatch_report() {
>> +    spatch --dir lib \
>> +	   --ignore lib/parse_opts.c \
>> +	   --ignore lib/newlib_tests \
>> +	   --ignore lib/tests \
>> +	   --use-gitgrep \
>> +	   -D report \
>> +	   --include-headers \
>> +	   $*
>> +}
>> +
>> +libltp_spatch_fix() {
>> +    spatch --dir lib \
>> +	   --ignore lib/parse_opts.c \
>> +	   --ignore lib/newlib_tests \
>> +	   --ignore lib/tests \
>> +	   --use-gitgrep \
>> +	   --in-place \
>> +	   -D fix \
>> +	   --include-headers \
>> +	   $*
>> +}
>> +
>> +echo You should uncomment one of the scripts below!
>> +#libltp_spatch_report --sp-file scripts/coccinelle/libltp-test-macro.cocci
>> +#libltp_spatch_report --sp-file scripts/coccinelle/libltp-test-macro-vars.cocci \
>> +#		     --ignore lib/tst_test.c
> Maybe have getopts to specify what needs to be running would prevent a need to
> modify versioned file.

+1

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

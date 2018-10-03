From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 3 Oct 2018 12:46:20 +0200
Subject: [LTP] [RFC PATCH 1/1] Add automated tests for shell lib
In-Reply-To: <20181003095107.GD23398@rei>
References: <20180829172448.GA2960@dell5510>
 <cover.1535725022.git.clanig@suse.com>
 <c859d712cb33f6bb151313d6664d786920e49500.1535725022.git.clanig@suse.com>
 <20181003095107.GD23398@rei>
Message-ID: <20181003104620.GA21139@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +do_test()
> > +{
> > +	tst_res TPASS "Test $1 passed with data '$2': a: '$ALTERNATIVE', f: '$MODE'"
> > +}
> > +
> > +tst_run
> > +# output:
> > +# test 1 TPASS: Test 1 passed with data '': a: '0', f: 'foo'
> > +# 
> > +# Summary:
> > +# passed   1
> > +# failed   0
> > +# skipped  0
> > +# warnings 0

> We do need a way how to pass parameters to the tests so that we can test
> this functionality properly (and also the default options that are
> implemented in the test library).

> Obvious way how to do this is to allow to have several output: blocks at
> the end of the test with a different parameters, something as:

> # output:
> # test 1 TPASS: Test 1 passed with data '': a: '0', f: 'foo'

> # Summary:
> # passed   1
> # failed   0
> # skipped  0
> # warnings 0

> # output:
> # params: -a
> # test 1 TPASS: Test 1 passed with data '': a: '1', f: 'foo'

> # Summary:
> # passed   1
> # failed   0
> # skipped  0
> # warnings 0

> ...

Good idea!

...
> > +verify_output()
> > +{
> > +	[ -e "$sh_lib_tst_dir$tst" ] || { printf "$tst not found\n" && \
> > +			cleanup 1 ;}
> > +	# read all lines after line: `# output:`, and strip `# ` from beginning
> > +	sed -n -e '/^# output:/,$ p;' "$sh_lib_tst_dir$tst" | sed '1d; s/^# //'\
> > +			> "$tmp_dir$tst.wanted" || cleanup 1

> Usually doing more complex text manipulation is easier with awk

> In this case you can use gsub() function that will replace substring and
> print all lines that were replaced (i.e. print all comments without the
> hash and space):

> awk 'gsub("^# ", "", $0)' script.sh

> Then you can even get one of the output: blocks with:

> awk -vb=1 'gsub("^# ", "", $0) {if (/output:/) {p++}; if (p==b && !/output:/) {print $0}};' script.sh
>        ^
>        This gives you content of comments starting at first # output:
>        line up to the next # output: or end of line, which is exactly
>        what we need if we want to support passing parameters to
>        testcases. Then we can simply count how many # output: lines are
>        in a file and then run this command in a loop extracting one
>        example output after another.
I wonder whether "extracting one example output after another" is still good to
do in awk/sed/shell (with simple readable code). Probably yes, but I wouldn't
mind to have either python (pytest) or some perl code doing it.
Awk is everywhere and definitely more capable than sed or even shell, but not
everybody is fluent in it.


Kind regards,
Petr

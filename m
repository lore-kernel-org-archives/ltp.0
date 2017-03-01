From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Mar 2017 11:35:14 +0100
Subject: [LTP] runltp-ng hackweek experiment
In-Reply-To: <20170301101149.5hlkduqfdvlxmpqx@dell5510>
References: <20170228142912.GA13189@rei.lan>
 <20170301101149.5hlkduqfdvlxmpqx@dell5510>
Message-ID: <20170301103513.GA17074@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It looks really interesting.
> 
> BTW while Open Posix Testcases (-o switch) are working, "normal" tests doesn't. Do I miss
> something?
> 
> $ /opt/ltp/bin/ltp-runner -S /opt/ltp/runtest/io

The -S option sets a skipfile, runtest files are passed as positional
parameters.

> Overall results:
> -------------------------------------
> 
> Passed 0 out of 0
> 
> 
> And shouldn't there be a different check as otherwise it segfaults?
> 
> $ /opt/ltp/bin/ltp-runner -S /opt/ltp/runtest/mm
> Segmentation fault (core dumped)

Hmm, looks like a bug.

> --- tools/runltp-ng/bin/runner_test_filter.c
> +++ tools/runltp-ng/bin/runner_test_filter.c
> @@ -100,7 +100,7 @@ static void trie_insert(const char *str)
>  
>  	str = trie_search(str, &node);
>  
> -	while (*str) {
> +	while (str) {
>  		int key = char2key(*str);
>  
>  		if (key == -1)

Does not look correct, we are looping over the string characters here
inserting nodes into the tree. Here we likely segfault since the
trie_search() encountered unexpected character and returned NULL since I
deliberately allow only printable ascii characters in the test id. So we
should do something as:

	str = trie_search(str, &node);

	if (!str) {
		WARN("Invalid character found in '%s'", str);
		return;
	}

> >   - The code is split into several modules, the parsers prepare list of
> >     tests to be executed, then there is code to execute the tests and
> >     store logs, then the output writers can produce logs in several
> >     different formats. I've experimented a bit with a better html
> >     output[4][5] (table sorting is not implemented yet, but planned).
> 
> Tables looks very nice. I'd be for more features like hover highlighting a and slightly
> different color for odd and even rows, but thats a detail (see
> http://adminer.sourceforge.net/adminer.php?username=&db=a264133_6rgs7fa4 as example).

I have something like that in mind as well, the table was done in a half
of a day and I've spend most of the time looking into javascript
documentation...

But I've managed to write a table sorting function yesterday evenning, I
will push that code into my github repo soon enough.

-- 
Cyril Hrubis
chrubis@suse.cz

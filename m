From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 Mar 2017 11:11:49 +0100
Subject: [LTP] runltp-ng hackweek experiment
In-Reply-To: <20170228142912.GA13189@rei.lan>
References: <20170228142912.GA13189@rei.lan>
Message-ID: <20170301101149.5hlkduqfdvlxmpqx@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> I've tried to experiment with a proof of concept for new LTP test
> execution framework during Hackweek[1]. And I've ended up with something
> that is more or less usable and has features missing in runltp + ltp-pan
> script we have now.

> It's in the proof of concept state at this point and polishing it would
> require more work, but it looks promising at this point.

It looks really interesting.

BTW while Open Posix Testcases (-o switch) are working, "normal" tests doesn't. Do I miss
something?

$ /opt/ltp/bin/ltp-runner -S /opt/ltp/runtest/io

Overall results:
-------------------------------------

Passed 0 out of 0


And shouldn't there be a different check as otherwise it segfaults?

$ /opt/ltp/bin/ltp-runner -S /opt/ltp/runtest/mm
Segmentation fault (core dumped)

--- tools/runltp-ng/bin/runner_test_filter.c
+++ tools/runltp-ng/bin/runner_test_filter.c
@@ -100,7 +100,7 @@ static void trie_insert(const char *str)
 
 	str = trie_search(str, &node);
 
-	while (*str) {
+	while (str) {
 		int key = char2key(*str);
 
 		if (key == -1)


>   - The code is split into several modules, the parsers prepare list of
>     tests to be executed, then there is code to execute the tests and
>     store logs, then the output writers can produce logs in several
>     different formats. I've experimented a bit with a better html
>     output[4][5] (table sorting is not implemented yet, but planned).

Tables looks very nice. I'd be for more features like hover highlighting a and slightly
different color for odd and even rows, but thats a detail (see
http://adminer.sourceforge.net/adminer.php?username=&db=a264133_6rgs7fa4 as example).


Kind regards,
Petr

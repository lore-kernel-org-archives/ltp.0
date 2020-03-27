From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 27 Mar 2020 11:17:37 +0100
Subject: [LTP] [PATCH 2/2] Avoid zero or negative int results in
 calculations
In-Reply-To: <20200327095715.GA16912@dell5510>
References: <20200324143839.3647c485@daedruan>
 <20200326084504.GB29830@dell5510> <20200326134603.GA5185@yuki.lan>
 <20200326203222.GA19445@dell5510> <20200327095715.GA16912@dell5510>
Message-ID: <98d9d28a-5da8-5c28-3b8f-0678a4988eda@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27. 03. 20 10:57, Petr Vorel wrote:
> Hi,
> 
>> Before:
>> real	0m0,013s
> 
>> After (slowed by second commit, not by the rewrite):
>> real	0m0,402s
> 
> Although the slowdown it's ~30 times, it's obviously fast enough,
> so I wouldn't consider it as a problem. I was just surprised by it.

Like I said in the previous e-mail, that slowdown is caused by the test
intentionally randomizing the number of disk writes, not the patch. Run
the test several times.

> My concern is about brief explanation where/how is zero or negative result
> appears. But maybe it's obvious and I just don't see it.

Let me explain.

> @@ -60,17 +61,15 @@ static void run(void) {

>  	double time_delta;

>  	long int random_number;

>  

> -	while (max_block <= data_blocks) {

> -		random_number = rand();

> -		max_block = random_number % max_blks;

> -		data_blocks = random_number % 1000 + 1;

> -	}

> +	random_number = rand();

> +	max_block = random_number % max_blks + 1;

> +	data_blocks = random_number % max_block;


This fixes a potential infinite loop if max_blks == 1000. This
calculation is also the reason why the test has random run length.

>  

>  	for (i = 1; i <= data_blocks; i++) {

>  		offset = i * ((BLOCKSIZE * max_block) / data_blocks);

> -		offset -= BUFSIZ;

> +		offset -= BUF_SIZE;


Here the old calculation could produce negative offset if
BUFSIZ > BLOCKSIZE and (float)max_block/data_blocks is close to 1.
BUFSIZ is defined in libc headers so the actual value can be different
on different systems.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

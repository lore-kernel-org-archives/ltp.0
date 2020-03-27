From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 27 Mar 2020 09:42:44 +0100
Subject: [LTP] [PATCH v3] Fix use after stack unwind in fzsync lib
In-Reply-To: <20200326204107.GA26499@dell5510>
References: <20200326152828.14934-1-mdoucha@suse.cz>
 <20200326204107.GA26499@dell5510>
Message-ID: <5b99cab2-5f9e-47f0-15f1-3dfdb02920ac@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26. 03. 20 21:41, Petr Vorel wrote:
> Hi Martin,
> 
>> tst_fzsync_pair_reset() passes a local variable to thread B which may be
>> already unwinded by the time the thread wrapper function executes. If new
>> variables get allocated and initialized on stack between pthread_create()
>> and thread wrapper execution, thread B will segfault.
> 
> I naively assumed this would fix SIGKILL signal for CVE 2018-1000199 test,
> but it didn't.

No, the fuzzysync fix is unrelated to the CVE-2018-1000199 test. I ran
into mysterious segfaults while writing a test for CVE-2018-18559 which
I haven't finished yet.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

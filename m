From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 25 May 2020 16:50:37 +0200
Subject: [LTP] [PATCH v2 3/3] Add test for CVE 2017-1000111
In-Reply-To: <20200525141510.GC26837@dell5510>
References: <20200505152315.29216-1-mdoucha@suse.cz>
 <20200505152315.29216-3-mdoucha@suse.cz> <20200525141510.GC26837@dell5510>
Message-ID: <f24e98c8-0aba-aaeb-0401-dafe2fffa897@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25. 05. 20 16:15, Petr Vorel wrote:
> Hi Martin,
> 
>> +static void setup(void)
>> +{
>> +	int real_uid = getuid();
>> +	int real_gid = getgid();
> 
> Don't we want to add here taint check (you had it in v1)?
> tst_taint_init(TST_TAINT_W | TST_TAINT_D);

Taint check is meaningless in this test because the only ill effect from
the race condition is that all incoming packets will be truncated to 0
bytes. Somebody would have to horribly break the code for receiving
incoming packets in order to turn this bug into something that can
actually taint the kernel.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

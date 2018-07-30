From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon, 30 Jul 2018 17:01:16 +0100
Subject: [LTP] [PATCH v2] ltp-pan: Increase allowed width of test name
	in logs
In-Reply-To: <20180730154857.GB19202@rei> (Cyril Hrubis's message of "Mon, 30
 Jul 2018 17:48:57 +0200")
References: <20180730121941.GB14198@rei>
 <20180730153607.15074-1-punit.agrawal@arm.com>
 <20180730154857.GB19202@rei>
Message-ID: <871sbk7lwz.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
>> index a2bb9b7ef..6a4508c90 100644
>> --- a/pan/ltp-pan.c
>> +++ b/pan/ltp-pan.c
>> @@ -130,6 +130,9 @@ static char *test_out_dir = NULL;	/* dir to buffer output to */
>>  zoo_t zoofile;
>>  static char *reporttype = NULL;
>>  
>> +/* Output format of ltp-pan results */
>> +#define ResultFmt	"%-50s %-10.10s %-10.10s\n";
>
> The ltp-pan does not even compile with this because of the semicolon.
>
> Can you please at least compile-test your changes before sumbitting.

Ack! That is very sloppy of me. I'll be more careful going forward.

>>  /* zoolib */
>>  int rec_signal;			/* received signal */
>>  int send_signal;		/* signal to send */
>> @@ -350,9 +353,9 @@ int main(int argc, char **argv)
>>  			fprintf(logfile, "Test Start Time: %s\n", s);
>>  			fprintf(logfile,
>>  				"-----------------------------------------\n");
>> -			fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n",
>> +			fprintf(logfile, ResultFmt,
>>  				"Testcase", "Result", "Exit Value");
>> -			fprintf(logfile, "%-30.20s %-10.10s %-10.10s\n",
>> +			fprintf(logfile, ResultFmt,
>>  				"--------", "------", "------------");
>>  		}
>>  		fflush(logfile);
>> @@ -825,7 +828,7 @@ check_pids(struct tag_pgrp *running, int *num_active, int keep_active,
>>  						}
>>  
>>  						fprintf(logfile,
>> -							"%-30.30s %-10.10s %-5d\n",
>> +							ResultFmt,
>>  							running[i].cmd->name,
>>  							result_str,
>>  							w);
>> @@ -1104,7 +1107,7 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
>>  				if (termid != 0)
>>  					++ * failcnt;
>>  
>> -				fprintf(logfile, "%-30.30s %-10.10s %-5d\n",
>> +				fprintf(logfile, ResultFmt,
>>  					colle->name,
>>  					((termid != 0) ? "FAIL" : "PASS"),
>>  					termid);
>
> Looking closer these two are actually different in the last column. So I
> suppose that we can extract only the first two columns as with:
>
> #define ResultFmt "%-50s %-10.10s"
>
> 	...
> 	fprintf(..., ResultFmt" %-10.10%s\n", ...);
> 	...
> 	fprintf(,,,, ResultFmt" %-5d\n", ...);
> 	...

I've taken this approach now and will send an updated patch with the
changes.

Thanks,
Punit

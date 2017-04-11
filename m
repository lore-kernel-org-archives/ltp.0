From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 11 Apr 2017 11:36:43 +0800
Subject: [LTP] [PATCH] pan/ltp-pan.c: fix incorrect number of total tests
In-Reply-To: <20170410135021.GC23301@rei.lan>
References: <1491544700-6312-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20170410135021.GC23301@rei.lan>
Message-ID: <58EC4F4B.7040003@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 2017/04/10 21:50, Cyril Hrubis wrote:
> Hi!
>>   pan/ltp-pan.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
>> index 1614c70..beed623 100644
>> --- a/pan/ltp-pan.c
>> +++ b/pan/ltp-pan.c
>> @@ -645,7 +645,7 @@ int main(int argc, char **argv)
>>   				strerror(errno));
>>   		fprintf(logfile,
>>   			"\n-----------------------------------------------\n");
>> -		fprintf(logfile, "Total Tests: %d\n", coll->cnt);
>> +		fprintf(logfile, "Total Tests: %d\n", (coll->cnt - starts));
> This change does not make much sense to me. The coll->cnt is number of
> tests loaded from the runtest file, right? The starts is basically
> number of tests to be executed. The runltp script executes ltp-pan with
> -S which means that starts is set to coll->cnt in the main() function
> and so after this change it would print "Total Tests: 0" regardless.
>
Hi Cyril

Actually, the coll->cnt is number of tests loaded from the runtest file.
However, starts is set to coll->cnt at first , and it reduces when=20
completing one test.
Please see the following code:
cpid =3D
run_child(coll->ary[c], running + i, quiet_mode,
&failcnt, fmt_print, logfile);
if (cpid !=3D -1)
++num_active;
if ((cpid !=3D -1 || sequential) && starts > 0)
--starts;

I think that ltp-pan could indicate the number of tests which have been=20
run when receiving one signal.
I am not familiar with ltp-pan code=EF=BC=8Cso do you have some suggestions=
=20
about it?

Thanks,
Xiao Yang.



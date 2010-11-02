Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PD6BV-0003eD-OL
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 02:01:13 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PD6BU-0000IP-FA
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 02:01:13 +0000
Received: by wwb31 with SMTP id 31so6252084wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Nov 2010 19:01:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CCF64E0.4060909@cn.fujitsu.com>
References: <4CC8D859.4010701@cn.fujitsu.com> <4CCF64E0.4060909@cn.fujitsu.com>
Date: Mon, 1 Nov 2010 19:00:52 -0700
Message-ID: <AANLkTikoFVWxMxx07EEGxsRuiWowrkr+_M3UCHnjPZrT@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [POSIX][PATCH]Some building error at pi_test cases.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

    Will be committed momentarily.
Thanks!
-Garrett

On Mon, Nov 1, 2010 at 6:09 PM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> =A0Would you like to pick up this patch? =A0^_^
>
> Best Regards
> =A0Bian
>
>> Commit 5f2ba92bdbef089bad74906fd8a86b54617f7878 make some building error.
>>
>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>>
>> ---
>> =A0.../functional/threads/pi_test/pitest-2.c =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 +-
>> =A0.../functional/threads/pi_test/pitest-3.c =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 ++--
>> =A0.../functional/threads/pi_test/pitest-4.c =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 ++--
>> =A0.../functional/threads/pi_test/pitest-6.c =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 ++--
>> =A04 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/p=
itest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pites=
t-2.c
>> index 62f1f45..0a96377 100644
>> --- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2=
.c
>> +++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2=
.c
>> @@ -235,7 +235,7 @@ void *thread_tb2(void *arg)
>> =A0 =A0 =A0 DPRINTF(stdout, "#EVENT %f TB2 Thread Started\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 seconds_read() - base_time);
>>
>> - =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t*)timeoutsec;
>> + =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t*)arg;
>> =A0 =A0 =A0 boost_time.tv_nsec =3D 0;
>>
>> =A0 =A0 =A0 t0 =3D seconds_read();
>> diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/p=
itest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pites=
t-3.c
>> index fe0c886..58d7a4a 100644
>> --- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3=
.c
>> +++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3=
.c
>> @@ -219,7 +219,7 @@ void *thread_tb1(void *arg)
>> =A0 =A0 =A0 DPRINTF(stdout, "#EVENT %f Thread TB1 Started\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 seconds_read() - base_time);
>>
>> - =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)timeoutsec;
>> + =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)arg;
>> =A0 =A0 =A0 boost_time.tv_nsec =3D 0;
>>
>> =A0 =A0 =A0 t0 =3D seconds_read();
>> @@ -247,7 +247,7 @@ void *thread_tb2(void *arg)
>> =A0 =A0 =A0 DPRINTF(stdout, "#EVENT %f Thread TB2 Started\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 seconds_read() - base_time);
>>
>> - =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)timeoutsec;
>> + =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)arg;
>> =A0 =A0 =A0 boost_time.tv_nsec =3D 0;
>> =A0 =A0 =A0 t0 =3D seconds_read();
>> =A0 =A0 =A0 rc =3D pthread_mutex_timedlock(&mutex2, &boost_time);
>> diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/p=
itest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pites=
t-4.c
>> index a042dbf..077f966 100644
>> --- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4=
.c
>> +++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4=
.c
>> @@ -187,7 +187,7 @@ void *thread_tb1(void *arg)
>>
>> =A0 =A0 =A0 pthread_mutex_lock(&mutex2);
>>
>> - =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)timeoutsec;
>> + =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)arg;
>> =A0 =A0 =A0 boost_time.tv_nsec =3D 0;
>> =A0 =A0 =A0 t0 =3D seconds_read();
>> =A0 =A0 =A0 rc =3D pthread_mutex_timedlock(&mutex1, &boost_time);
>> @@ -218,7 +218,7 @@ void *thread_tb2(void *arg)
>> =A0 =A0 =A0 DPRINTF(stdout, "#EVENT %f Thread TB2 Started\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 seconds_read() - base_time);
>>
>> - =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)timeoutsec;
>> + =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)arg;
>> =A0 =A0 =A0 boost_time.tv_nsec =3D 0;
>>
>> =A0 =A0 =A0 t0 =3D seconds_read();
>> diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/p=
itest-6.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pites=
t-6.c
>> index 6ebb003..2f2272b 100644
>> --- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6=
.c
>> +++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6=
.c
>> @@ -204,9 +204,9 @@ void *thread_tb(void *arg)
>> =A0 =A0 =A0 DPRINTF(stderr,"Thread TB: started\n");
>>
>> =A0 =A0 =A0 DPRINTF(stdout, "#EVENT %f TB Started, waiting for mutex for=
 %lu s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 seconds_read() - base_time, timeoutsec);
>> + =A0 =A0 =A0 =A0 =A0 =A0 seconds_read() - base_time, *(unsigned long*)a=
rg);
>>
>> - =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)timeoutsec;
>> + =A0 =A0 boost_time.tv_sec =3D time(NULL) + *(time_t *)arg;
>> =A0 =A0 =A0 boost_time.tv_nsec =3D 0;
>>
>> =A0 =A0 =A0 t0 =3D seconds_read();
>
> --
> Regards
> Bian Naimeng
>
>

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

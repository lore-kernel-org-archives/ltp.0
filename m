Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1RaLLq-0000v3-Rs
	for ltp-list@lists.sourceforge.net; Tue, 13 Dec 2011 05:56:30 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RaLLn-0003Kr-9A
	for ltp-list@lists.sourceforge.net; Tue, 13 Dec 2011 05:56:30 +0000
Received: by ggnh1 with SMTP id h1so8026358ggn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Dec 2011 21:56:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EE1D27A.6000600@cn.fujitsu.com>
References: <1323419326-13172-1-git-send-email-kai.kang@windriver.com>
	<1323419326-13172-3-git-send-email-kai.kang@windriver.com>
	<4EE1D27A.6000600@cn.fujitsu.com>
Date: Mon, 12 Dec 2011 21:56:21 -0800
Message-ID: <CAGH67wQKH_iXJ59eDikG89_DzgGAU5n-_Sd9hoFt8devOFOmKg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/2] pthread_rwlock_unlock/4-2: remove local var
	'rc'
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 9, 2011 at 1:18 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wro=
te:
> On 12/09/2011 04:28 PM, Kang Kai wrote:
>
>> Local var 'rc' in function main hides the global one. In child thread
>> it sets global var 'rc' with funtion return value. But in function main,
>> test var 'rc' always succeeds because it tests local var 'rc'.
>>
>
>
> Good catch.
>
> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>
>> Signed-off-by: Kang Kai <kai.kang@windriver.com>
>> ---
>> =A0.../interfaces/pthread_rwlock_unlock/4-2.c =A0 =A0 =A0 =A0 | =A0 =A03=
 +--
>> =A01 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthre=
ad_rwlock_unlock/4-2.c b/testcases/open_posix_testsuite/conformance/interfa=
ces/pthread_rwlock_unlock/4-2.c
>> index 3023886..4928f85 100644
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlo=
ck_unlock/4-2.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlo=
ck_unlock/4-2.c
>> @@ -54,7 +54,6 @@ static void* fn_unlk(void *arg)
>> =A0int main()
>> =A0{
>> =A0 =A0 =A0 int cnt =3D 0;
>> - =A0 =A0 int rc =3D 0;
>>
>> =A0 =A0 =A0 pthread_t un_thread;
>>
>> @@ -125,4 +124,4 @@ int main()
>>
>> =A0 =A0 =A0 printf("Test PASSED: Note*: Returned 0 instead of EPERM, but=
 standard specified _may_ fail.\n");
>> =A0 =A0 =A0 return PTS_PASS;
>> -}
>> \ No newline at end of file
>> +}

Will be committed soon (kind of interesting why -Wshadow didn't
identify this issue...).
-Garrett

---------------------------------------------------------------------------=
---
Systems Optimization Self Assessment
Improve efficiency and utilization of IT resources. Drive out cost and =

improve service delivery. Take 5 minutes to use this Systems Optimization =

Self Assessment. http://www.accelacomm.com/jaw/sdnl/114/51450054/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

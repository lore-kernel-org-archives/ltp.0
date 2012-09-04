Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ritesh.harjani@gmail.com>) id 1T8k9v-0003HM-52
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 03:50:39 +0000
Received: from mail-wg0-f41.google.com ([74.125.82.41])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1T8k9t-0002hH-VH
	for ltp-list@lists.sourceforge.net; Tue, 04 Sep 2012 03:50:39 +0000
Received: by wgbds1 with SMTP id ds1so2543792wgb.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Sep 2012 20:50:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABhB_e8j2oRbKPererNep1-T5z3sCsvRPW-2rSoPg-tvF4AZoA@mail.gmail.com>
References: <CAD15agakqdqNiZY_rKRyh0GocADu7F2rLdctJpSwdosiNz7CYg@mail.gmail.com>
	<CABhB_e8j2oRbKPererNep1-T5z3sCsvRPW-2rSoPg-tvF4AZoA@mail.gmail.com>
Date: Tue, 4 Sep 2012 09:20:31 +0530
Message-ID: <CAD15agZmMyu+vWLoRn1NukgaeXvG-v6pbxs=fUVULTQc6DLhgg@mail.gmail.com>
From: Ritesh Harjani <ritesh.harjani@gmail.com>
Subject: Re: [LTP] LTP test reults for kernel 3.0.15 and 3.4
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8770961186246729907=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: tadimarri sarath <sarath.tadi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============8770961186246729907==
Content-Type: multipart/alternative; boundary=f46d043c80b4e8620804c8d828a6

--f46d043c80b4e8620804c8d828a6
Content-Type: text/plain; charset=ISO-8859-1

Hi sarath,

Following are the lines of code where the test case is exiting, for kernel
3.0.15 (ICS).

128         pm2=pm1;
129         free(pm1);
130
131         if((pm1=(char *)calloc(memsize,1)) == NULL) {
132                 tst_resm(TFAIL, "calloc did not alloc memory ");
133                              tst_exit();
134         }
135
136         if(pm1 != pm2) {
137                 tst_resm(TINFO, "pm1=%p pm2=%p ", pm1,pm2);
138                 tst_resm(TFAIL, "free did not dealloc memory ");
139
tst_exit();                                                     // *Here
code is exited in kernel 3.0.15 while it is passing in case of kernel 3.4
(ICS)*.
140         }



*LTP version = "LTP-20100630"*

at line 136 my test is failing. Now isnt this condition of the dangling
pointer. At line 129 we are freeing pm1 this means that pm2 becomes a
dangling pointer.
And how come after doing
pm1=(char *)calloc(memsize,1)
pm1 is equal to pm2 for kernel 3.4 (ICS) (Since this test case is passing
for that)??

According to me, it should not be equal.

Ritesh


On Mon, Sep 3, 2012 at 6:55 PM, tadimarri sarath <sarath.tadi@gmail.com>wrote:

> Hi Ritesh,
>
> May I know which version of the LTP you have used and the filesystem
> environment used ?
> The source can be found here
> It is a testcase which does series of checks that memory can be allocated
> and freed with various calloc, malloc, free, realloc, valloc functions.
> please refer to the source here :
> testcases/kernel/mem/mem/mem02.c
>
> Regards,
> Sarath.
>
> On Mon, Sep 3, 2012 at 10:37 AM, Ritesh Harjani <ritesh.harjani@gmail.com>wrote:
>
>> Has anyone tried running LTP tests on kernel 3.0.15 (Android ICS) and
>> kernel 3.4 (Android ICS)
>>
>> Actually there is mem02 test which is failing in kernel 3.0.15 which is
>> not the case with kernel 3.4.
>> So, if anyone can point out why the difference and also if someone can
>> direct me onto what exactly this test does and
>> some source of information from where i can have a deeper understanding
>> on this.
>>
>> Thank you
>> Ritesh
>>
>>
>> ------------------------------------------------------------------------------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and
>> threat landscape has changed and how IT managers can respond. Discussions
>> will include endpoint security, mobile security and the latest in malware
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>>
>

--f46d043c80b4e8620804c8d828a6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi sarath,<br><br>Following are the lines of code where the test case is ex=
iting, for kernel 3.0.15 (ICS). <br><br>128=A0 =A0=A0=A0=A0=A0=A0 pm2=3Dpm1=
;<br>129=A0=A0=A0=A0=A0=A0=A0=A0 free(pm1);<br>130<br>131=A0=A0=A0=A0=A0=A0=
=A0=A0 if((pm1=3D(char *)calloc(memsize,1)) =3D=3D NULL) {<br>
132=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_resm(TFAIL, &quot;c=
alloc did not alloc memory &quot;);<br>133=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_exit();<br>134=
=A0=A0=A0=A0=A0=A0=A0=A0 }<br>135<br>136=A0=A0=A0=A0=A0=A0=A0=A0 if(pm1 !=
=3D pm2) {<br>137=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_resm(=
TINFO, &quot;pm1=3D%p pm2=3D%p &quot;, pm1,pm2);<br>
138=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_resm(TFAIL, &quot;f=
ree did not dealloc memory &quot;);<br>139=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_exit();=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 //=
 <b>Here code is exited in kernel 3.0.15 while it is passing in case of ker=
nel 3.4 (ICS)</b>. <br>
140=A0=A0=A0=A0=A0=A0=A0=A0 }<br><br><br><br><b>LTP version =3D &quot;LTP-2=
0100630&quot;</b><br><br>at line 136 my test is failing. Now isnt this cond=
ition of the dangling pointer. At line 129 we are freeing pm1 this means th=
at pm2 becomes a dangling pointer. <br>
And how come after doing <br>pm1=3D(char *)calloc(memsize,1)<br>pm1 is equa=
l to pm2 for kernel 3.4 (ICS) (Since this test case is passing for that)?? =
<br><br>According to me, it should not be equal. <br><br>Ritesh<br><br><br>
<div class=3D"gmail_quote">On Mon, Sep 3, 2012 at 6:55 PM, tadimarri sarath=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:sarath.tadi@gmail.com" target=3D"_=
blank">sarath.tadi@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
Hi Ritesh, <br><br>May I know which version of the LTP you have used and th=
e filesystem environment used ? <br>The source can be found here<br>It is a=
 testcase which does series of checks that memory can be allocated and free=
d with various calloc, malloc, free, realloc, valloc functions.<br>

please refer to the source here :<br>testcases/kernel/mem/mem/mem02.c<br><b=
r>Regards,<br>Sarath.<br><br><div class=3D"gmail_quote"><div><div class=3D"=
h5">On Mon, Sep 3, 2012 at 10:37 AM, Ritesh Harjani <span dir=3D"ltr">&lt;<=
a href=3D"mailto:ritesh.harjani@gmail.com" target=3D"_blank">ritesh.harjani=
@gmail.com</a>&gt;</span> wrote:<br>

</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div cla=
ss=3D"h5">Has anyone tried running LTP tests on kernel 3.0.15 (Android ICS)=
 and kernel 3.4 (Android ICS)<br>
<br>Actually there is mem02 test which is failing in kernel 3.0.15 which is=
 not the case with kernel 3.4. <br>
So, if anyone can point out why the difference and also if someone can dire=
ct me onto what exactly this test does and <br>
some source of information from where i can have a deeper understanding on =
this. <br><br>Thank you <br><span><font color=3D"#888888">Ritesh<br>
</font></span><br></div></div>---------------------------------------------=
---------------------------------<br>
Live Security Virtual Conference<br>
Exclusive live event will cover all the ways today&#39;s security and<br>
threat landscape has changed and how IT managers can respond. Discussions<b=
r>
will include endpoint security, mobile security and the latest in malware<b=
r>
threats. <a href=3D"http://www.accelacomm.com/jaw/sfrnl04242012/114/5012226=
3/" target=3D"_blank">http://www.accelacomm.com/jaw/sfrnl04242012/114/50122=
263/</a><br>_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net" target=3D"_blank">Ltp-lis=
t@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br></blockquote></div><br>
</blockquote></div><br>

--f46d043c80b4e8620804c8d828a6--


--===============8770961186246729907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============8770961186246729907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8770961186246729907==--


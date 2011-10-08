Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joshiplns@gmail.com>) id 1RCNUm-0006lZ-3a
	for ltp-list@lists.sourceforge.net; Sat, 08 Oct 2011 03:22:40 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RCNUk-0003my-TS
	for ltp-list@lists.sourceforge.net; Sat, 08 Oct 2011 03:22:40 +0000
Received: by bke11 with SMTP id 11so7659228bke.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 Oct 2011 20:22:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADfK0X4ScZbwutFoB5h05jD3-qeCdwURjyNfNRbTMHxxdO_neg@mail.gmail.com>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
	<CAMhs6YxRdWGBwg2R4aCSJtB9ZFTYFfOEO+=GvrL0yKa0cM-Z6Q@mail.gmail.com>
	<CADfK0X4ScZbwutFoB5h05jD3-qeCdwURjyNfNRbTMHxxdO_neg@mail.gmail.com>
Date: Sat, 8 Oct 2011 08:52:30 +0530
Message-ID: <CADfK0X7hP+5B8UA4pm9gDk40t+rpC_KNMQ3hdiNJq6H5x4DV6A@mail.gmail.com>
From: "Josh!" <joshiplns@gmail.com>
Subject: Re: [LTP] ltp-pan: cannot execute binary file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1433170363090547313=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Maxin B John <maxin.john@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============1433170363090547313==
Content-Type: multipart/alternative; boundary=001517588b5a60248004aec111c2

--001517588b5a60248004aec111c2
Content-Type: text/plain; charset=ISO-8859-1

Hi Maxin,

>
> I'm sharing you following info regarding your last comment
>
> +++++
> /opt/Joshi_LTP4/bin # file ltp-pan
> ltp-pan: ELF 32-bit LSB execable, Intel 80386SYSV), for GNU/Li dynamically
> linkhared libs), not stripped
> +++++
>
> Even though exporting CROSS_COMPILER it still compiling for X86 not for
> armv7a.
> In Make file not able to find out CROSS_COMPILER .
>
> Joshi
>
> On Tue, Oct 4, 2011 at 6:16 PM, Maxin B John <maxin.john@gmail.com> wrote:
>
>> Hi Joshi,
>>
>> On Tue, Oct 4, 2011 at 3:41 PM, Josh! <joshiplns@gmail.com> wrote:
>>
>>> Hi,
>>>
>>> Any Inputs  ?
>>>
>>
>> Please share the output of this command:
>>
>> # file /mnt/HDD/ltp-full-20110915/Joshi_LTP/bin/ltp-pan
>>
>> WBR,
>> Maxin B. John
>>
>>
>>
>>> On Fri, Sep 30, 2011 at 2:22 PM, Josh! <joshiplns@gmail.com> wrote:
>>>
>>>> Hi folks ,
>>>>
>>>> I am running 3.0 Kernel for armv7a on *Beagle Board* target.
>>>>
>>>> Meanwhile I'm testing kernel with ltp-full-20110915. I did the Make and
>>>> Make Install properly.
>>>> But while running ./runltp script I am facing following issue.
>>>>
>>>> {{{
>>>>
>>>> ./runltp: line 824: /mnt/HDD/ltp-full-20110915/Joshi_LTP/bin/ltp-pan:
>>>> cannot execute binary file
>>>> INFO: ltp-pan reportedAIL
>>>>
>>>> }}}
>>>>
>>>> Could anyone can share knowledge on this issue ?
>>>>
>>>> Kindly
>>>> Joshi
>>>>
>>>>
>>>
>>>
>>> --
>>>
>>>
>>>
>>>
>>>
>>> ------------------------------------------------------------------------------
>>> All the data continuously generated in your IT infrastructure contains a
>>> definitive record of customers, application performance, security
>>> threats, fraudulent activity and more. Splunk takes this data and makes
>>> sense of it. Business sense. IT sense. Common sense.
>>> http://p.sf.net/sfu/splunk-d2dcopy1
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>
>>>
>>
>
>
> --
>

--001517588b5a60248004aec111c2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font><font><br></font></font><span class=3D"Apple-style-s=
pan" style=3D"color: rgb(51, 51, 153); font-family: &#39;trebuchet ms&#39;,=
 sans-serif; font-size: large; ">Hi Maxin,</span><font><font><br></font></f=
ont><div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div dir=3D"ltr"><font color=3D"#333399"><f=
ont size=3D"4"><font face=3D"trebuchet ms,sans-serif"><br>I&#39;m sharing y=
ou following info regarding your last comment<br>
<br>+++++<br>/opt/Joshi_LTP4/bin # file ltp-pan <br>
ltp-pan: ELF 32-bit LSB execable, Intel 80386SYSV), for GNU/Li dynamically =
linkhared libs), not stripped<br>+++++<br><br>Even though exporting CROSS_C=
OMPILER it still compiling for X86 not for armv7a.<br>In Make file not able=
 to find out </font></font></font><font color=3D"#333399"><font size=3D"4">=
<font face=3D"trebuchet ms,sans-serif">CROSS_COMPILER .<br>

<br>Joshi<br></font></font></font><div><div></div><div class=3D"h5"><br><di=
v class=3D"gmail_quote">On Tue, Oct 4, 2011 at 6:16 PM, Maxin B John <span =
dir=3D"ltr">&lt;<a href=3D"mailto:maxin.john@gmail.com" target=3D"_blank">m=
axin.john@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204, 204, 204);padding-left:1ex">
Hi Joshi,<br><br><div class=3D"gmail_quote">On Tue, Oct 4, 2011 at 3:41 PM,=
 Josh! <span dir=3D"ltr">&lt;<a href=3D"mailto:joshiplns@gmail.com" target=
=3D"_blank">joshiplns@gmail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rg=
b(204, 204, 204);padding-left:1ex">


<div dir=3D"ltr"><font color=3D"#333399"><font size=3D"4"><font face=3D"tre=
buchet ms,sans-serif"><span><span style=3D"background-color:rgb(51, 0, 51)"=
><span style=3D"color:rgb(255, 255, 102);background-color:rgb(255, 204, 204=
)"><span style=3D"color:rgb(51, 0, 51);background-color:rgb(255, 255, 255)"=
>Hi,<br>



<br style=3D"color:rgb(51, 0, 51);background-color:rgb(255, 255, 255)"></sp=
an><span style=3D"color:rgb(255, 255, 255)"><span style=3D"color:rgb(51, 0,=
 51)"><span style=3D"background-color:rgb(255, 255, 255)">Any Inputs=A0 ?<b=
r>


</span></span></span></span></span></span></font></font></font></div></bloc=
kquote><div><br>Please share the output of this command:<br><br># file /mnt=
/HDD/ltp-full-20110915/Joshi_LTP/bin/ltp-pan<br><br>WBR,<br>Maxin B. John<b=
r>


<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt =
0.8ex;border-left:1px solid rgb(204, 204, 204);padding-left:1ex"><div><div>=
</div><div><div dir=3D"ltr"><font color=3D"#333399"><font size=3D"4"><font =
face=3D"trebuchet ms,sans-serif"><span><span style=3D"background-color:rgb(=
51, 0, 51)"><span style=3D"color:rgb(255, 255, 102);background-color:rgb(25=
5, 204, 204)"></span></span></span></font></font></font><div>


<div></div><div>On Fri, Sep 30, 2011 at 2:22 PM, Josh! <span dir=3D"ltr">&l=
t;<a href=3D"mailto:joshiplns@gmail.com" target=3D"_blank">joshiplns@gmail.=
com</a>&gt;</span> wrote:<br>
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204, 204, 204);padding-left:1=
ex"><div dir=3D"ltr">Hi folks ,<br><br>I am running 3.0 Kernel for armv7a o=
n *Beagle Board* target.<br>



<br>Meanwhile I&#39;m testing kernel with ltp-full-20110915. I did the Make=
 and Make Install properly.<br>But while running ./runltp script I am facin=
g following issue.<br>
<br>{{{<br><br>./runltp: line 824: /mnt/HDD/ltp-full-20110915/Joshi_LTP/bin=
/ltp-pan: cannot execute binary file<br>INFO: ltp-pan reportedAIL<br><br>}}=
}<br><br>Could anyone can share knowledge on this issue ?<br><br>Kindly<br>




Joshi<br><br>
</div>
</blockquote></div><br><br clear=3D"all"><br></div></div><font class=3D"App=
le-style-span" color=3D"#888888">-- </font><br><div><div><p><font class=3D"=
Apple-style-span" color=3D"#2a5db0"><br></font></p></div></div><span style=
=3D"color:rgb(51, 51, 153)"></span><span style=3D"color:rgb(51, 51, 153)"><=
/span><br>

</div>
<br></div></div>-----------------------------------------------------------=
-------------------<br>
All the data continuously generated in your IT infrastructure contains a<br=
>
definitive record of customers, application performance, security<br>
threats, fraudulent activity and more. Splunk takes this data and makes<br>
sense of it. Business sense. IT sense. Common sense.<br>
<a href=3D"http://p.sf.net/sfu/splunk-d2dcopy1" target=3D"_blank">http://p.=
sf.net/sfu/splunk-d2dcopy1</a><br>_________________________________________=
______<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net" target=3D"_blank">Ltp-lis=
t@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br></blockquote></div><br>
</blockquote></div><br><br clear=3D"all"><br>--</div></div></div></blockquo=
te></div>
</div>

--001517588b5a60248004aec111c2--


--===============1433170363090547313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security
threats, fraudulent activity, and more. Splunk takes this data and makes
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2dcopy2
--===============1433170363090547313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1433170363090547313==--


Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1NUKfg-00012Z-Vt
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 13:51:04 +0000
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143])
	by sfi-mx-3.v28.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NUKfe-000067-BM
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 13:51:04 +0000
Message-ID: <4B4B2CA8.1000401@st.com>
Date: Mon, 11 Jan 2010 14:50:32 +0100
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <4B41E55D.2020801@st.com>	
	<ECC1F2A4-FC8C-4626-904B-F29FB9CB209E@gmail.com>
	<1262864216.12213.37.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1262864216.12213.37.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] mtest01: free memory allocated
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5495523264035710797=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============5495523264035710797==
Content-Type: multipart/alternative;
	boundary="------------040204000702070207040009"

This is a multi-part message in MIME format.
--------------040204000702070207040009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dear All,

Ok, likely a sort of flag has to be added in the "mtest01.c" 
code.....something like that:

mem_flag=0;
....................

if((mem = (char*)malloc(chunksize)) == NULL) {

.......

exit(1)
}

mem_flag=1:

.......


in order to understand if the malloc() has been executed or not.....and 
then the patch will be:

if ((mem_flag==1)&&(mem != NULL))
{
         free(mem);
         mem_flag=0;
}

Without a patch as above (or like that), in the code of  "mtest01" we 
got scenarios (mainly in the cross architectures like embedded systems) 
in which the LTP run a "malloc()" without "free()".
This is always wrong even though the system resource is enough to cover 
this memory consumption.

Regards
--
FR


Subrata Modak wrote:

>Garrett,
>
>On Mon, 2010-01-04 at 18:10 -0800, Garrett Cooper wrote: 
>  
>
>>On Jan 4, 2010, at 4:55 AM, Francesco RUNDO <francesco.rundo@st.com>  
>>wrote:
>>
>>    
>>
>>>Hi All,
>>>
>>>I'm running LTP (I'm using ltp-full-20090731....but asap I will  
>>>upgrade to latest)  on SH based platforms.
>>>Now, during a test-session. I've noted that the test "mtest01"  
>>>reduced drastically the system memory and after its execution this  
>>>memory wasn't de-allocated.
>>>
>>>I've analysed the mtest01.c code and I've noted that no "free()"  
>>>istruction was associated to the related malloc:
>>>
>>>......
>>>if((mem = (char*)malloc(chunksize)) == NULL) {
>>>......
>>>
>>>I've simply added a "free(mem)" of the allocated memory and the  
>>>issue was addressed successfully.
>>>
>>>I've attached the trivial patch I've developed.
>>>
>>>Best Regards,
>>>--
>>>Francesco
>>>Added missed "free" istruction to release memory previosuly allocated.
>>>Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
>>>--- ltp-full-20090731/testcases/kernel/mem/mtest01/ 
>>>mtest01.c.origin    2009-02-26 13:02:27.000000000 +0100
>>>+++ ltp-full-20090731/testcases/kernel/mem/mtest01/mtest01.c     
>>>2009-12-15 14:03:28.779240000 +0100
>>>@@ -258,5 +258,8 @@
>>>    else
>>>      tst_resm(TPASS, "%llu kbytes allocated only.",  
>>>original_maxbytes/1024);
>>>  }
>>>+
>>>+  free(mem);
>>>+
>>>  exit(0);
>>>}
>>>      
>>>
>>1. Does the version off cvs still have this issue?
>>2. Unless the test exits the code block immediately, I'd definitely do:
>>
>>if (mem)
>>     free (mem);
>>
>>to avoid making a bad free call.
>>    
>>
>
>Have you made any changes to this ? I do not see any commits.
>
>Regards--
>Subrata
>
>  
>
>>Thanks,
>>-Garrett
>>
>>------------------------------------------------------------------------------
>>This SF.Net email is sponsored by the Verizon Developer Community
>>Take advantage of Verizon's best-in-class app development support
>>A streamlined, 14 day to market process makes app distribution fast and easy
>>Join now and get one step closer to millions of Verizon customers
>>http://p.sf.net/sfu/verizon-dev2dev 
>>_______________________________________________
>>Ltp-list mailing list
>>Ltp-list@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/ltp-list
>>    
>>
>
>
>  
>

--------------040204000702070207040009
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Dear All,<br>
<br>
Ok, likely a sort of flag has to be added in the "mtest01.c"
code.....something like that:<br>
<br>
mem_flag=0;<br>
....................<br>
<pre wrap="">if((mem = (char*)malloc(chunksize)) == NULL) {

.......
</pre>
exit(1)<br>
}<br>
<pre wrap="">mem_flag=1:</pre>
.......<br>
<br>
<br>
in order to understand if the malloc() has been executed or not.....and
then the patch will be:<br>
<br>
if ((mem_flag==1)&amp;&amp;(mem != NULL))<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(mem);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_flag=0;<br>
}<br>
<br>
Without a patch as above (or like that), in the code of&nbsp; "mtest01" we
got scenarios (mainly in the cross architectures like embedded systems)
in which the LTP run a "malloc()" without "free()". <br>
This is always wrong even though the system resource is enough to cover
this memory consumption.<br>
<br>
Regards<br>
--<br>
FR<br>
<br>
<br>
Subrata Modak wrote:<br>
<blockquote type="cite"
 cite="mid1262864216.12213.37.camel@subratamodak.linux.ibm.com">
  <pre wrap="">Garrett,

On Mon, 2010-01-04 at 18:10 -0800, Garrett Cooper wrote: 
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Jan 4, 2010, at 4:55 AM, Francesco RUNDO <a class="moz-txt-link-rfc2396E" href="mailto:francesco.rundo@st.com">&lt;francesco.rundo@st.com&gt;</a>  
wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">Hi All,

I'm running LTP (I'm using ltp-full-20090731....but asap I will  
upgrade to latest)  on SH based platforms.
Now, during a test-session. I've noted that the test "mtest01"  
reduced drastically the system memory and after its execution this  
memory wasn't de-allocated.

I've analysed the mtest01.c code and I've noted that no "free()"  
istruction was associated to the related malloc:

......
if((mem = (char*)malloc(chunksize)) == NULL) {
......

I've simply added a "free(mem)" of the allocated memory and the  
issue was addressed successfully.

I've attached the trivial patch I've developed.

Best Regards,
--
Francesco
Added missed "free" istruction to release memory previosuly allocated.
Signed-off-by: Francesco Rundo <a class="moz-txt-link-rfc2396E" href="mailto:francesco.rundo@st.com">&lt;francesco.rundo@st.com&gt;</a>
--- ltp-full-20090731/testcases/kernel/mem/mtest01/ 
mtest01.c.origin    2009-02-26 13:02:27.000000000 +0100
+++ ltp-full-20090731/testcases/kernel/mem/mtest01/mtest01.c     
2009-12-15 14:03:28.779240000 +0100
@@ -258,5 +258,8 @@
    else
      tst_resm(TPASS, "%llu kbytes allocated only.",  
original_maxbytes/1024);
  }
+
+  free(mem);
+
  exit(0);
}
      </pre>
    </blockquote>
    <pre wrap="">1. Does the version off cvs still have this issue?
2. Unless the test exits the code block immediately, I'd definitely do:

if (mem)
     free (mem);

to avoid making a bad free call.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Have you made any changes to this ? I do not see any commits.

Regards--
Subrata

  </pre>
  <blockquote type="cite">
    <pre wrap="">Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/verizon-dev2dev">http://p.sf.net/sfu/verizon-dev2dev</a> 
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
</body>
</html>

--------------040204000702070207040009--



--===============5495523264035710797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============5495523264035710797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5495523264035710797==--



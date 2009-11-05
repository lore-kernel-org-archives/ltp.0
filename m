Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <markver@us.ibm.com>) id 1N5rOE-0006Ap-HD
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 01:43:54 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5rO7-0004xt-U2
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 01:43:54 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA51ZbaP029570
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Nov 2009 20:35:37 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA51hggI1351824
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Nov 2009 20:43:42 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA51hf8p031626
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Nov 2009 20:43:42 -0500
Received: from d01mc096.pok.ibm.com (d01mc096.pok.ibm.com [9.63.9.231])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	nA51hfgG031622
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Nov 2009 20:43:41 -0500
In-Reply-To: <364299f40911032158s4356a90bkf06686f7aea01b87@mail.gmail.com>
References: <mailman.103093.1257283106.5825.ltp-list@lists.sourceforge.net>	
	<OFB7192512.13ED74E7-ON85257664.001981A6-85257664.001F3BB6@us.ibm.com>
	<364299f40911032158s4356a90bkf06686f7aea01b87@mail.gmail.com>
Message-ID: <OF2EC662FD.A8CC841C-ON85257665.00084CCC-85257665.00097DBB@us.ibm.com>
From: Mark Ver <markver@us.ibm.com>
Date: Wed, 4 Nov 2009 20:43:40 -0500
MIME-Version: 1.0
Subject: Re: [LTP] Build Fails on some archs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5194831435454387534=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============5194831435454387534==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFCF6DF9BCA5C8f9e8a93df938690918c0ABBFCF6DF9BCA5C"
Content-Disposition: inline

--0__=0ABBFCF6DF9BCA5C8f9e8a93df938690918c0ABBFCF6DF9BCA5C
Content-type: text/plain; charset=US-ASCII

>> On SLES-10 SP3, the make attempt gets nowhere ...
>> h91distr02:~/ltp-full-20091031 # make all
>> make: *** No rule to make target `/$*', needed by `pan-all'.  Stop.
>> h91distr02:~/ltp-full-20091031 #
>> ...
>> On RHEL5.4 and SLES-11 am getting build problem with the controllers
>> subdirs,  ex:
>> ...
>
>     Someone else reported similar recently. Can you please tell us
> what version of Gnu make you're using?

SLES-10 SP3:  make-3.80-202.2

As for the ones failing on the controllers/cgroup stuff:

SLES-11:    make-3.81-128.20
RHEL5.4:    make-3.81-3.el5


- Mark Ver

office:  Building 710 / Room 2-RF-10
phone: (845) 435-7794  [tie 8 295-7794]
--0__=0ABBFCF6DF9BCA5C8f9e8a93df938690918c0ABBFCF6DF9BCA5C
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>&gt;&gt; On SLES-10 SP3, the make attempt gets nowhere ...<br>
&gt;&gt; h91distr02:~/ltp-full-20091031 # make all<br>
&gt;&gt; make: *** No rule to make target `/$*', needed by `pan-all'. &nbsp;Stop.<br>
&gt;&gt; h91distr02:~/ltp-full-20091031 #</tt><br>
<tt>&gt;&gt; ...</tt><br>
<tt>&gt;&gt; On RHEL5.4 and SLES-11 am getting build problem with the controllers <br>
&gt;&gt; subdirs, &nbsp;ex:</tt><br>
<tt>&gt;&gt; ...</tt><br>
<tt>&gt;</tt><br>
<tt>&gt; &nbsp; &nbsp; Someone else reported similar recently. Can you please tell us<br>
&gt; what version of Gnu make you're using?</tt><br>
<br>
<tt>SLES-10 SP3: &nbsp;make-3.80-202.2</tt><br>
<br>
<tt>As for the ones failing on the controllers/cgroup stuff:</tt><br>
<br>
<tt>SLES-11:	</tt><tt>make-3.81-128.20</tt><br>
<tt>RHEL5.4:	</tt><tt>make-3.81-3.el5</tt><br>
<br>
<br>
- Mark Ver<br>
<br>
office:  Building 710 / Room 2-RF-10<br>
phone: (845) 435-7794  [tie 8 295-7794]<br>
</body></html>
--0__=0ABBFCF6DF9BCA5C8f9e8a93df938690918c0ABBFCF6DF9BCA5C--



--===============5194831435454387534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5194831435454387534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5194831435454387534==--



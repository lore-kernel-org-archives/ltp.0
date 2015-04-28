Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yn27H-0006XP-WF
	for ltp-list@lists.sourceforge.net; Tue, 28 Apr 2015 09:47:48 +0000
Date: Tue, 28 Apr 2015 11:47:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150428094713.GA19096@rei>
References: <1555406842.5673672.1429863249724.JavaMail.zimbra@redhat.com>
	<782230467.5857849.1429883677704.JavaMail.zimbra@redhat.com>
	<20150427132404.GA10567@rei.suse.de>
	<699964060.6783089.1430144771050.JavaMail.zimbra@redhat.com>
	<20150427155840.GF10567@rei.suse.de>
	<1789445018.7218822.1430210865329.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1789445018.7218822.1430210865329.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] Coverity report for ltp-20150420
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
New report attached.

Looking at data, the rapid increase in compiler warnings between 20140115 and
20140422 corresponds to:

commit 20eb071295762dc14649c10308d193936dded0ca
Author: Alexey Kodanev <alexey.kodanev@oracle.com>
Date:   Fri Apr 11 13:26:59 2014 +0400

    configure: add configure check for GCC -Wold-style-definition

commit dcd5af4f811e582feaec3bf01df89d7a0ec05d6e
Author: Cyril Hrubis <metan@ucw.cz>
Date:   Mon Jan 20 17:03:26 2014 +0100

    config.mk.in: Turn on extra warnings.

    Don't forget to regenerate and rerun the configure script.

So to get reasonable data for these we will have to pass -W
-Wold-style-definition to the configure to releases before 20140422.

I have no idea though, why 20130109 has only 171 warnings, that seems very odd.

-- 
Cyril Hrubis
chrubis@suse.cz

--3MwIy2ne0vdjdPXF
Content-Type: text/html; charset=us-ascii
Content-Disposition: attachment; filename="report.html"

<html>
 <head>
 <title>LTP Coverity in time</title>
 </head>
 <body>
  <h1>Comparsion to the previous version</h1>
  <table bgcolor="#eee">
   <tr>
    <td></td>
    <td colspan="2" align="center"><b>20130109</b></td>
    <td colspan="2" align="center"><b>20130503</b></td>
    <td colspan="2" align="center"><b>20130904</b></td>
    <td colspan="2" align="center"><b>20140115</b></td>
    <td colspan="2" align="center"><b>20140422</b></td>
    <td colspan="2" align="center"><b>20140828</b></td>
    <td colspan="2" align="center"><b>20150119</b></td>
    <td colspan="2" align="center"><b>20150420</b></td>
   </tr>
   <tr>
    <td>ARRAY_VS_SINGLETON</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">1</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>BAD_ALLOC_STRLEN</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">0</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>BAD_COMPARE</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">4</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>BAD_FREE</td>
    <td align="right" bgcolor="#999999">15</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">15</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">15</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">15</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">17</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#999999">17</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">17</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">17</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>CHAR_IO</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>CHECKED_RETURN</td>
    <td align="right" bgcolor="#999999">339</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">330</td>
    <td align="right" bgcolor="#55ff55">(-9)</td>
    <td align="right" bgcolor="#ff5555">347</td>
    <td align="right" bgcolor="#ff5555">(+17)</td>
    <td align="right" bgcolor="#ff5555">349</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#999999">349</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">338</td>
    <td align="right" bgcolor="#55ff55">(-11)</td>
    <td align="right" bgcolor="#55ff55">328</td>
    <td align="right" bgcolor="#55ff55">(-10)</td>
    <td align="right" bgcolor="#55ff55">319</td>
    <td align="right" bgcolor="#55ff55">(-9)</td>
   </tr>
   <tr>
    <td>COMPILER_WARNING</td>
    <td align="right" bgcolor="#999999">171</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#ff5555">1106</td>
    <td align="right" bgcolor="#ff5555">(+935)</td>
    <td align="right" bgcolor="#ff5555">1487</td>
    <td align="right" bgcolor="#ff5555">(+381)</td>
    <td align="right" bgcolor="#ff5555">1500</td>
    <td align="right" bgcolor="#ff5555">(+13)</td>
    <td align="right" bgcolor="#ff5555">2945</td>
    <td align="right" bgcolor="#ff5555">(+1445)</td>
    <td align="right" bgcolor="#55ff55">2836</td>
    <td align="right" bgcolor="#55ff55">(-109)</td>
    <td align="right" bgcolor="#55ff55">2801</td>
    <td align="right" bgcolor="#55ff55">(-35)</td>
    <td align="right" bgcolor="#55ff55">2622</td>
    <td align="right" bgcolor="#55ff55">(-179)</td>
   </tr>
   <tr>
    <td>CONSTANT_EXPRESSION_RESULT</td>
    <td align="right" bgcolor="#999999">5</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">4</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">5</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">5</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">4</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#ff5555">6</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>COPY_PASTE_ERROR</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">3</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>DEADCODE</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">28</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">28</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">29</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">30</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#55ff55">29</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>EVALUATION_ORDER</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>FORWARD_NULL</td>
    <td align="right" bgcolor="#999999">43</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">43</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">43</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">45</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#999999">45</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">44</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">44</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">43</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
   </tr>
   <tr>
    <td>IDENTICAL_BRANCHES</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>INFINITE_LOOP</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">0</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>MISSING_BREAK</td>
    <td align="right" bgcolor="#999999">58</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">57</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#ff5555">59</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#55ff55">19</td>
    <td align="right" bgcolor="#55ff55">(-40)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">21</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
   </tr>
   <tr>
    <td>NEGATIVE_RETURNS</td>
    <td align="right" bgcolor="#999999">685</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">498</td>
    <td align="right" bgcolor="#55ff55">(-187)</td>
    <td align="right" bgcolor="#999999">498</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">500</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">501</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">502</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">503</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#55ff55">497</td>
    <td align="right" bgcolor="#55ff55">(-6)</td>
   </tr>
   <tr>
    <td>NO_EFFECT</td>
    <td align="right" bgcolor="#999999">21</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">21</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">13</td>
    <td align="right" bgcolor="#55ff55">(-8)</td>
    <td align="right" bgcolor="#ff5555">16</td>
    <td align="right" bgcolor="#ff5555">(+3)</td>
    <td align="right" bgcolor="#55ff55">15</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">15</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">15</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">7</td>
    <td align="right" bgcolor="#55ff55">(-8)</td>
   </tr>
   <tr>
    <td>NULL_RETURNS</td>
    <td align="right" bgcolor="#999999">10</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#ff5555">11</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#55ff55">10</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#55ff55">6</td>
    <td align="right" bgcolor="#55ff55">(-4)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>OVERFLOW_BEFORE_WIDEN</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>OVERRUN</td>
    <td align="right" bgcolor="#999999">28</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">24</td>
    <td align="right" bgcolor="#55ff55">(-4)</td>
    <td align="right" bgcolor="#ff5555">25</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">26</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">26</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">26</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">27</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">27</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>PASS_BY_VALUE</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>RESOURCE_LEAK</td>
    <td align="right" bgcolor="#999999">329</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#ff5555">330</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">332</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">355</td>
    <td align="right" bgcolor="#ff5555">(+23)</td>
    <td align="right" bgcolor="#55ff55">352</td>
    <td align="right" bgcolor="#55ff55">(-3)</td>
    <td align="right" bgcolor="#55ff55">341</td>
    <td align="right" bgcolor="#55ff55">(-11)</td>
    <td align="right" bgcolor="#55ff55">340</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#ff5555">343</td>
    <td align="right" bgcolor="#ff5555">(+3)</td>
   </tr>
   <tr>
    <td>RETURN_LOCAL</td>
    <td align="right" bgcolor="#999999">2</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">1</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>REVERSE_INULL</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>REVERSE_NEGATIVE</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">2</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">2</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">2</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">2</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>SIZEOF_MISMATCH</td>
    <td align="right" bgcolor="#999999">22</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">20</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">19</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#55ff55">18</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">18</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">19</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>STRAY_SEMICOLON</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>UNINIT</td>
    <td align="right" bgcolor="#999999">114</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">99</td>
    <td align="right" bgcolor="#55ff55">(-15)</td>
    <td align="right" bgcolor="#55ff55">97</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#999999">97</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">96</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#55ff55">93</td>
    <td align="right" bgcolor="#55ff55">(-3)</td>
    <td align="right" bgcolor="#999999">93</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">91</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
   </tr>
   <tr>
    <td>UNREACHABLE</td>
    <td align="right" bgcolor="#999999">67</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#55ff55">66</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">66</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">14</td>
    <td align="right" bgcolor="#55ff55">(-52)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>UNUSED_VALUE</td>
    <td align="right" bgcolor="#999999">8</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">8</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">8</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">8</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">8</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">6</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>USE_AFTER_FREE</td>
    <td align="right" bgcolor="#999999">46</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">46</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">46</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">46</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">47</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">47</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">47</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">48</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
   </tr>
   <tr>
    <td>VARARGS</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">1</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>TOTAL</td>
    <td align="right" bgcolor="#999999">2014</td>
    <td align="right" bgcolor="#999999">(none)</td>
    <td align="right" bgcolor="#ff5555">2727</td>
    <td align="right" bgcolor="#ff5555">(+713)</td>
    <td align="right" bgcolor="#ff5555">3116</td>
    <td align="right" bgcolor="#ff5555">(+389)</td>
    <td align="right" bgcolor="#55ff55">3066</td>
    <td align="right" bgcolor="#55ff55">(-50)</td>
    <td align="right" bgcolor="#ff5555">4512</td>
    <td align="right" bgcolor="#ff5555">(+1446)</td>
    <td align="right" bgcolor="#55ff55">4376</td>
    <td align="right" bgcolor="#55ff55">(-136)</td>
    <td align="right" bgcolor="#55ff55">4335</td>
    <td align="right" bgcolor="#55ff55">(-41)</td>
    <td align="right" bgcolor="#55ff55">4136</td>
    <td align="right" bgcolor="#55ff55">(-199)</td>
   </tr>
  </table>

  <h1>Comparsion to the latest version</h1>

  <table bgcolor="#eee">
   <tr>
    <td></td>
    <td colspan="2" align="center"><b>20130109</b></td>
    <td colspan="2" align="center"><b>20130503</b></td>
    <td colspan="2" align="center"><b>20130904</b></td>
    <td colspan="2" align="center"><b>20140115</b></td>
    <td colspan="2" align="center"><b>20140422</b></td>
    <td colspan="2" align="center"><b>20140828</b></td>
    <td colspan="2" align="center"><b>20150119</b></td>
    <td colspan="2" align="center"><b>20150420</b></td>
   </tr>
   <tr>
    <td>ARRAY_VS_SINGLETON</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>BAD_ALLOC_STRLEN</td>
    <td align="right" bgcolor="#55ff55">1</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>BAD_COMPARE</td>
    <td align="right" bgcolor="#55ff55">6</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">6</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>BAD_FREE</td>
    <td align="right" bgcolor="#ff5555">15</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">15</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">15</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">15</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#999999">17</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">17</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">17</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">17</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>CHAR_IO</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>CHECKED_RETURN</td>
    <td align="right" bgcolor="#55ff55">339</td>
    <td align="right" bgcolor="#55ff55">(-20)</td>
    <td align="right" bgcolor="#55ff55">330</td>
    <td align="right" bgcolor="#55ff55">(-11)</td>
    <td align="right" bgcolor="#55ff55">347</td>
    <td align="right" bgcolor="#55ff55">(-28)</td>
    <td align="right" bgcolor="#55ff55">349</td>
    <td align="right" bgcolor="#55ff55">(-30)</td>
    <td align="right" bgcolor="#55ff55">349</td>
    <td align="right" bgcolor="#55ff55">(-30)</td>
    <td align="right" bgcolor="#55ff55">338</td>
    <td align="right" bgcolor="#55ff55">(-19)</td>
    <td align="right" bgcolor="#55ff55">328</td>
    <td align="right" bgcolor="#55ff55">(-9)</td>
    <td align="right" bgcolor="#999999">319</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>COMPILER_WARNING</td>
    <td align="right" bgcolor="#ff5555">171</td>
    <td align="right" bgcolor="#ff5555">(+2451)</td>
    <td align="right" bgcolor="#ff5555">1106</td>
    <td align="right" bgcolor="#ff5555">(+1516)</td>
    <td align="right" bgcolor="#ff5555">1487</td>
    <td align="right" bgcolor="#ff5555">(+1135)</td>
    <td align="right" bgcolor="#ff5555">1500</td>
    <td align="right" bgcolor="#ff5555">(+1122)</td>
    <td align="right" bgcolor="#55ff55">2945</td>
    <td align="right" bgcolor="#55ff55">(-323)</td>
    <td align="right" bgcolor="#55ff55">2836</td>
    <td align="right" bgcolor="#55ff55">(-214)</td>
    <td align="right" bgcolor="#55ff55">2801</td>
    <td align="right" bgcolor="#55ff55">(-179)</td>
    <td align="right" bgcolor="#999999">2622</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>CONSTANT_EXPRESSION_RESULT</td>
    <td align="right" bgcolor="#ff5555">5</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">4</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">4</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">5</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">5</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">4</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>COPY_PASTE_ERROR</td>
    <td align="right" bgcolor="#55ff55">4</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>DEADCODE</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">28</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">28</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">30</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>EVALUATION_ORDER</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>FORWARD_NULL</td>
    <td align="right" bgcolor="#999999">43</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">43</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">43</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#55ff55">45</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">45</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">44</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#55ff55">44</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">43</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>IDENTICAL_BRANCHES</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>INFINITE_LOOP</td>
    <td align="right" bgcolor="#55ff55">1</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#55ff55">1</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#55ff55">1</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">0</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>MISSING_BREAK</td>
    <td align="right" bgcolor="#55ff55">58</td>
    <td align="right" bgcolor="#55ff55">(-37)</td>
    <td align="right" bgcolor="#55ff55">57</td>
    <td align="right" bgcolor="#55ff55">(-36)</td>
    <td align="right" bgcolor="#55ff55">59</td>
    <td align="right" bgcolor="#55ff55">(-38)</td>
    <td align="right" bgcolor="#ff5555">19</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">19</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">19</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">19</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#999999">21</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>NEGATIVE_RETURNS</td>
    <td align="right" bgcolor="#55ff55">685</td>
    <td align="right" bgcolor="#55ff55">(-188)</td>
    <td align="right" bgcolor="#55ff55">498</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#55ff55">498</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#55ff55">500</td>
    <td align="right" bgcolor="#55ff55">(-3)</td>
    <td align="right" bgcolor="#55ff55">501</td>
    <td align="right" bgcolor="#55ff55">(-4)</td>
    <td align="right" bgcolor="#55ff55">502</td>
    <td align="right" bgcolor="#55ff55">(-5)</td>
    <td align="right" bgcolor="#55ff55">503</td>
    <td align="right" bgcolor="#55ff55">(-6)</td>
    <td align="right" bgcolor="#999999">497</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>NO_EFFECT</td>
    <td align="right" bgcolor="#55ff55">21</td>
    <td align="right" bgcolor="#55ff55">(-14)</td>
    <td align="right" bgcolor="#55ff55">21</td>
    <td align="right" bgcolor="#55ff55">(-14)</td>
    <td align="right" bgcolor="#55ff55">13</td>
    <td align="right" bgcolor="#55ff55">(-6)</td>
    <td align="right" bgcolor="#55ff55">16</td>
    <td align="right" bgcolor="#55ff55">(-9)</td>
    <td align="right" bgcolor="#55ff55">15</td>
    <td align="right" bgcolor="#55ff55">(-8)</td>
    <td align="right" bgcolor="#55ff55">15</td>
    <td align="right" bgcolor="#55ff55">(-8)</td>
    <td align="right" bgcolor="#55ff55">15</td>
    <td align="right" bgcolor="#55ff55">(-8)</td>
    <td align="right" bgcolor="#999999">7</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>NULL_RETURNS</td>
    <td align="right" bgcolor="#55ff55">10</td>
    <td align="right" bgcolor="#55ff55">(-4)</td>
    <td align="right" bgcolor="#55ff55">11</td>
    <td align="right" bgcolor="#55ff55">(-5)</td>
    <td align="right" bgcolor="#55ff55">10</td>
    <td align="right" bgcolor="#55ff55">(-4)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>OVERFLOW_BEFORE_WIDEN</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>OVERRUN</td>
    <td align="right" bgcolor="#55ff55">28</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#ff5555">24</td>
    <td align="right" bgcolor="#ff5555">(+3)</td>
    <td align="right" bgcolor="#ff5555">25</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">26</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">26</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">26</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">27</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">27</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>PASS_BY_VALUE</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>RESOURCE_LEAK</td>
    <td align="right" bgcolor="#ff5555">329</td>
    <td align="right" bgcolor="#ff5555">(+14)</td>
    <td align="right" bgcolor="#ff5555">330</td>
    <td align="right" bgcolor="#ff5555">(+13)</td>
    <td align="right" bgcolor="#ff5555">332</td>
    <td align="right" bgcolor="#ff5555">(+11)</td>
    <td align="right" bgcolor="#55ff55">355</td>
    <td align="right" bgcolor="#55ff55">(-12)</td>
    <td align="right" bgcolor="#55ff55">352</td>
    <td align="right" bgcolor="#55ff55">(-9)</td>
    <td align="right" bgcolor="#ff5555">341</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">340</td>
    <td align="right" bgcolor="#ff5555">(+3)</td>
    <td align="right" bgcolor="#999999">343</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>RETURN_LOCAL</td>
    <td align="right" bgcolor="#55ff55">2</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>REVERSE_INULL</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>REVERSE_NEGATIVE</td>
    <td align="right" bgcolor="#ff5555">1</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">1</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">1</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">1</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">2</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">2</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">2</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">2</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>SIZEOF_MISMATCH</td>
    <td align="right" bgcolor="#55ff55">22</td>
    <td align="right" bgcolor="#55ff55">(-3)</td>
    <td align="right" bgcolor="#55ff55">20</td>
    <td align="right" bgcolor="#55ff55">(-1)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#ff5555">18</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">18</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">19</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>STRAY_SEMICOLON</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>UNINIT</td>
    <td align="right" bgcolor="#55ff55">114</td>
    <td align="right" bgcolor="#55ff55">(-23)</td>
    <td align="right" bgcolor="#55ff55">99</td>
    <td align="right" bgcolor="#55ff55">(-8)</td>
    <td align="right" bgcolor="#55ff55">97</td>
    <td align="right" bgcolor="#55ff55">(-6)</td>
    <td align="right" bgcolor="#55ff55">97</td>
    <td align="right" bgcolor="#55ff55">(-6)</td>
    <td align="right" bgcolor="#55ff55">96</td>
    <td align="right" bgcolor="#55ff55">(-5)</td>
    <td align="right" bgcolor="#55ff55">93</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">93</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#999999">91</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>UNREACHABLE</td>
    <td align="right" bgcolor="#55ff55">67</td>
    <td align="right" bgcolor="#55ff55">(-53)</td>
    <td align="right" bgcolor="#55ff55">66</td>
    <td align="right" bgcolor="#55ff55">(-52)</td>
    <td align="right" bgcolor="#55ff55">66</td>
    <td align="right" bgcolor="#55ff55">(-52)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>UNUSED_VALUE</td>
    <td align="right" bgcolor="#55ff55">8</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">8</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">8</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">8</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#55ff55">8</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>USE_AFTER_FREE</td>
    <td align="right" bgcolor="#ff5555">46</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">46</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">46</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">46</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right" bgcolor="#ff5555">47</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">47</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">47</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">48</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>VARARGS</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
   <tr>
    <td>TOTAL</td>
    <td align="right" bgcolor="#ff5555">2014</td>
    <td align="right" bgcolor="#ff5555">(+2122)</td>
    <td align="right" bgcolor="#ff5555">2727</td>
    <td align="right" bgcolor="#ff5555">(+1409)</td>
    <td align="right" bgcolor="#ff5555">3116</td>
    <td align="right" bgcolor="#ff5555">(+1020)</td>
    <td align="right" bgcolor="#ff5555">3066</td>
    <td align="right" bgcolor="#ff5555">(+1070)</td>
    <td align="right" bgcolor="#55ff55">4512</td>
    <td align="right" bgcolor="#55ff55">(-376)</td>
    <td align="right" bgcolor="#55ff55">4376</td>
    <td align="right" bgcolor="#55ff55">(-240)</td>
    <td align="right" bgcolor="#55ff55">4335</td>
    <td align="right" bgcolor="#55ff55">(-199)</td>
    <td align="right" bgcolor="#999999">4136</td>
    <td align="right" bgcolor="#999999">(0)</td>
   </tr>
  </table>
 </body>
</html>

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--3MwIy2ne0vdjdPXF--


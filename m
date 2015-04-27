Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YmlR8-0006G8-AL
	for ltp-list@lists.sourceforge.net; Mon, 27 Apr 2015 15:59:10 +0000
Date: Mon, 27 Apr 2015 17:58:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150427155840.GF10567@rei.suse.de>
References: <1555406842.5673672.1429863249724.JavaMail.zimbra@redhat.com>
	<782230467.5857849.1429883677704.JavaMail.zimbra@redhat.com>
	<20150427132404.GA10567@rei.suse.de>
	<699964060.6783089.1430144771050.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <699964060.6783089.1430144771050.JavaMail.zimbra@redhat.com>
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


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
And result of quick perl hackery is attached. Overall it's better, but
we keep adding warnings as well.

BTW: I can feed it easily with more data or share the script if you are
     interested.

-- 
Cyril Hrubis
chrubis@suse.cz

--vtzGhvizbBRQ85DL
Content-Type: text/html; charset=us-ascii
Content-Disposition: attachment; filename="report.html"

<html>
 <head>
 <title>LTP Coverity in time</title>
 </head>
 <body>
  <table bgcolor="#eee">
   <tr>
    <td></td>
    <td colspan="2">20140115</td>
    <td>20150422</td>
   </tr>
   <tr>
    <td>ARRAY_VS_SINGLETON</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>BAD_COMPARE</td>
    <td align="right" bgcolor="#999999">4</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">4</td>
   </tr>
   <tr>
    <td>BAD_FREE</td>
    <td align="right" bgcolor="#ff5555">15</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right">17</td>
   </tr>
   <tr>
    <td>CHAR_IO</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>CHECKED_RETURN</td>
    <td align="right" bgcolor="#55ff55">349</td>
    <td align="right" bgcolor="#55ff55">(-30)</td>
    <td align="right">319</td>
   </tr>
   <tr>
    <td>CONSTANT_EXPRESSION_RESULT</td>
    <td align="right" bgcolor="#ff5555">5</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right">6</td>
   </tr>
   <tr>
    <td>COPY_PASTE_ERROR</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">3</td>
   </tr>
   <tr>
    <td>DEADCODE</td>
    <td align="right" bgcolor="#999999">29</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">29</td>
   </tr>
   <tr>
    <td>EVALUATION_ORDER</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>FORWARD_NULL</td>
    <td align="right" bgcolor="#55ff55">45</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right">43</td>
   </tr>
   <tr>
    <td>IDENTICAL_BRANCHES</td>
    <td align="right" bgcolor="#999999">3</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">3</td>
   </tr>
   <tr>
    <td>MISSING_BREAK</td>
    <td align="right" bgcolor="#ff5555">19</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right">21</td>
   </tr>
   <tr>
    <td>NEGATIVE_RETURNS</td>
    <td align="right" bgcolor="#55ff55">500</td>
    <td align="right" bgcolor="#55ff55">(-3)</td>
    <td align="right">497</td>
   </tr>
   <tr>
    <td>NO_EFFECT</td>
    <td align="right" bgcolor="#55ff55">16</td>
    <td align="right" bgcolor="#55ff55">(-9)</td>
    <td align="right">7</td>
   </tr>
   <tr>
    <td>NULL_RETURNS</td>
    <td align="right" bgcolor="#999999">6</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">6</td>
   </tr>
   <tr>
    <td>OVERFLOW_BEFORE_WIDEN</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>OVERRUN</td>
    <td align="right" bgcolor="#ff5555">26</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right">27</td>
   </tr>
   <tr>
    <td>PASS_BY_VALUE</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>RESOURCE_LEAK</td>
    <td align="right" bgcolor="#55ff55">355</td>
    <td align="right" bgcolor="#55ff55">(-12)</td>
    <td align="right">343</td>
   </tr>
   <tr>
    <td>RETURN_LOCAL</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>REVERSE_INULL</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>REVERSE_NEGATIVE</td>
    <td align="right" bgcolor="#ff5555">1</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right">2</td>
   </tr>
   <tr>
    <td>SIZEOF_MISMATCH</td>
    <td align="right" bgcolor="#ff5555">18</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right">19</td>
   </tr>
   <tr>
    <td>STRAY_SEMICOLON</td>
    <td align="right" bgcolor="#999999">1</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>UNINIT</td>
    <td align="right" bgcolor="#55ff55">97</td>
    <td align="right" bgcolor="#55ff55">(-6)</td>
    <td align="right">91</td>
   </tr>
   <tr>
    <td>UNREACHABLE</td>
    <td align="right" bgcolor="#999999">14</td>
    <td align="right" bgcolor="#999999">(0)</td>
    <td align="right">14</td>
   </tr>
   <tr>
    <td>UNUSED_VALUE</td>
    <td align="right" bgcolor="#55ff55">8</td>
    <td align="right" bgcolor="#55ff55">(-2)</td>
    <td align="right">6</td>
   </tr>
   <tr>
    <td>USE_AFTER_FREE</td>
    <td align="right" bgcolor="#ff5555">46</td>
    <td align="right" bgcolor="#ff5555">(+2)</td>
    <td align="right">48</td>
   </tr>
   <tr>
    <td>VARARGS</td>
    <td align="right" bgcolor="#ff5555">0</td>
    <td align="right" bgcolor="#ff5555">(+1)</td>
    <td align="right">1</td>
   </tr>
   <tr>
    <td>TOTAL</td>
    <td align="right" bgcolor="#55ff55">1566</td>
    <td align="right" bgcolor="#55ff55">(-52)</td>
    <td align="right">1514</td>
   </tr>
  </table>
 </body>
</html>

--vtzGhvizbBRQ85DL
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
--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--vtzGhvizbBRQ85DL--


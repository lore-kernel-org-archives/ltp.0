Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shubgoya@in.ibm.com>) id 1PGUJx-0004F4-MJ
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 10:23:57 +0000
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGUJv-0004hF-MZ
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 10:23:57 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id oABANlCn019437
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 15:53:47 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oABANlGq352440
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 15:53:47 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oABANkNV003722
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 15:53:46 +0530
In-Reply-To: <OF7E98D2D1.7AEC88E3-ON652577D8.002CB466-652577D8.0030671A@LocalDomain>
References: <1289458673.5622.19.camel@subratamodak.linux.ibm.com>
	<OF7E98D2D1.7AEC88E3-ON652577D8.002CB466-652577D8.0030671A@LocalDomain>
Message-ID: <OF0CF663E4.3DA7EB94-ON652577D8.0037CCDB-652577D8.00391B71@in.ibm.com>
From: Shubham Goyal <shubgoya@in.ibm.com>
Date: Thu, 11 Nov 2010 15:53:31 +0530
MIME-Version: 1.0
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Iranna D Ankad <iranna.ankad@in.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, takahash <takahash@us.ibm.com>

Yes Iranna I agree with you and I also feel that "pounder21" tree should
not be removed from LTP. As you correctly said currently its difficult to
run LTP's pounder on stand alone systems due to some other helper files
dependency. I will try to address this problem ASAP and try to make pounder
run on stand alone systems without any other dependencies.  I have it in my
TODO list.

Thanks,
Shubham



                                                                           
             Iranna D                                                      
             Ankad/India/IBM                                               
                                                                        To 
             11/11/2010 02:17          subrata@linux.vnet.ibm.com,         
             PM                        yanegomi@gmail.com,                 
                                       shubgoya@in.ibm.com                 
                                                                        cc 
                                       LTP list                            
                                       <ltp-list@lists.sourceforge.net>,   
                                       Murlin Wenzel <mwenzel@novell.com>, 
                                       takahash <takahash@us.ibm.com>      
                                                                   Subject 
                                       Re: [LTP] [RFC] Remove              
                                       testcases/pounder21(Document link:  
                                       Shubham Goyal)                      
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           





Oh yes, IBM (especially SystemX team) still uses pounder for distro
validation. The thing is we use couple of other customized pounder scripts
in addition to the ones present in the LTP's "pounder21" directory, so that
dependent config files are downloaded & logs are saved from/to our repo
server. Having said that, we still require LTP's "pounder21" tree. So
please DO NOT remove it.

However, I agree that current pounder of LTP has some compatibility issues,
thereby making it difficult to run independently on a stand alone system.
This needs to be addressed and is in TODO list of our new pounder
maintainer "Shubham Goyal (shubgoya@in.ibm.com)".

@Shubham, any comments?

Thanks!
-Iranna D Ankad
----------------------------------------------------------------------------------------------------

Linux-Technology Center, IBM India Software Labs
Manyata Embassy Park, BENGALURU - 560045,
Ph: +91-080-28055007   Extn: 55007
----------------------------------------------------------------------------------------------------

"If you don't have patience to test the software, the software will test
your patience !!"

                                                                           
 Subrata Modak                                                             
 <subrata@linux.vnet.                                                      
 ibm.com>                                                               To 
                              Garrett Cooper <yanegomi@gmail.com>, Iranna  
                              D Ankad/India/IBM@IBMIN                      
 11/11/10 12:27 PM                                                      cc 
                              Murlin Wenzel <mwenzel@novell.com>, LTP list 
                              <ltp-list@lists.sourceforge.net>, takahash   
   Please respond to          <takahash@us.ibm.com>                        
  subrata@linux.vnet.                                              Subject 
        ibm.com               Re: [LTP] [RFC] Remove testcases/pounder21   
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           





On Wed, 2010-11-10 at 16:54 -0800, Garrett Cooper wrote:
> On Wed, Nov 10, 2010 at 12:53 PM, Murlin Wenzel <mwenzel@novell.com>
wrote:
> >>>> On 11/10/2010 at 01:28 PM, in message
> > <AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com>, Garrett
Cooper
> > <yanegomi@gmail.com> wrote:
> >> On Mon, Nov 8, 2010 at 1:57 PM, Garrett Cooper <yanegomi@gmail.com>
wrote:
> >>>    Hasn't compiled for a while, and looks pretty broken. If no one
> >>> objects to me removing it in 3 days I'll get rid of it.
> >>
> >> (retroactively as of yesterday)
> >> Going twice...
> >
> > I thought this was still being used by IBM in particular.  I know for a
fact it has multiple issues with file versions, missing/changed updates
etc.  Are you talking about removing the whole pounder tree?
>
> Answering my own question:
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09788.html
> , I asked this earlier on this year and someone replied saying "don't
> remove it". If it's not removed and serves a particular purpose, maybe
> it should be moved to a different section of the tree to avoid
> confusion in the future (in particular if it's a framework and not
> actually a test / test suite).

IBM still uses Pounder heavily for testing Distros. So, we can move it
to some other portion of the tree but still should be inside LTP.

Regards--
Subrata

> Thanks!
> -Garrett
>
>
------------------------------------------------------------------------------

> Centralized Desktop Delivery: Dell and VMware Reference Architecture
> Simplifying enterprise desktop deployment and management using
> Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
> client virtualization framework. Read more!
> http://p.sf.net/sfu/dell-eql-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list




------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

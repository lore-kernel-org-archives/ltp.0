From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 21 Mar 2018 18:12:57 +0300
Subject: [LTP] [PATCH] cve: new regression test-case for CVE-2018-5803
In-Reply-To: <87tvt9mrm4.fsf@rpws.prws.suse.cz>
References: <1520872613-30423-1-git-send-email-alexey.kodanev@oracle.com>
 <87tvt9mrm4.fsf@rpws.prws.suse.cz>
Message-ID: <df93800f-3fdc-ef52-e6fe-6eb7f49b34b4@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/21/2018 05:26 PM, Richard Palethorpe wrote:
> Hello Alexey,
> 
> Alexey Kodanev writes:
> 
>> There are two test-cases in runtest/cve:
>> * cve-2018-5803 - for over-sized INIT_ACK packet
>> * cve-2018-5803_2 - for over-sized INIT packet
> 
> Naming tests purely after a CVE number seems to have been a mistake on
> my part because people are unable to recognise them. Could this be given
> a more descriptive name and location (i.e something with net and sctp in
> the name?). Of course it should still go in the cve runtest file.

Hi Richard,

Sure, I'll move it to testcases/network/sctp/ and change the file name.

Thanks,
Alexey

From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 May 2017 12:35:44 +0200
Subject: [LTP] Correlation between test cases and .c files
In-Reply-To: <CADKPhiMPBt3o7no+G4_i+wKYrMGwZLjHXNgD=hJTU36j3SNsUw@mail.gmail.com>
References: <CADKPhiMYE5VeJEMkmgUww6c5ayn9D9SpA3ieF+-KYAZ=Xhopuw@mail.gmail.com>
 <20170330132239.GH12095@rei.lan>
 <CADKPhiMPBt3o7no+G4_i+wKYrMGwZLjHXNgD=hJTU36j3SNsUw@mail.gmail.com>
Message-ID: <20170502103544.GA6974@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We asked you about the testcases and their code. During our analysis we
> need to link the testcase name located at each lines of the files at runtest/
> directory
> 
> folder and its .c or .sh file. We saw that some tests (first word of each
> line) did not have any .c or .sh with the same name. Could you please
> explain it? There is no .c or .sh file for each line of runtest/ directory
> files? How can I correlate testscase with .c file that contain the test
> case ?

The first word on the line is just test name, that does not necessarily
correspond to a binary name or shell script filename. You have to look
at the rest of the line which is the command line to be executed as that
actually contains the binary or shell script filename, which then could
be used to find the test source code.

Do not be confused with the fact that most of the testcases have the
same test name (tag) as executable filename, this is not necessarily
true.

-- 
Cyril Hrubis
chrubis@suse.cz
